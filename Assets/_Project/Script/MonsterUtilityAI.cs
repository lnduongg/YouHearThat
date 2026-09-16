using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MonsterUtilityAI : MonoBehaviour
{
    public enum MonsterState { Hide, Stalk, Interfere, JumpScare }

    [Header("References")]
    public MonsterSpot[] allSpots;
    public CameraSystem cameraSystem;
    public GameStateManager gameStateManager;
    public CamperAI camper;
    public GameObject monsterMesh;
    public InkDialogueManager inkManager;
    public Camera playerCamera;

    [Header("Utility AI Engine")]
    public List<MonsterAction> availableActions;
    public MonsterAction bestAction;

    [Header("AI Configuration")]
    public float evaluationInterval = 15f;
    public MonsterState currentState;
    private float timer;
    private Transform lastCamPoint;
    private bool isExecutingSpecialAction = false;

    void Start()
    {
        timer = evaluationInterval;
        if (inkManager == null)
            inkManager = FindFirstObjectByType<InkDialogueManager>();
        TeleportToDefault();
    }

    void Update()
    {
        if (isExecutingSpecialAction)
            return;

        HandleQuantumHiding();

        timer -= Time.deltaTime;
        if (timer <= 0)
        {
            if (!IsMonsterVisibleToPlayer())
            {
                ChooseBestAction();
                ExecuteBestAction();
                timer = evaluationInterval;
            }
            else
            {
                timer = 2f;
            }
        }
    }

    void ChooseBestAction()
    {
        float highestScore = -1f;
        MonsterAction selected = null;
        foreach (var action in availableActions)
        {
            float score = action.Evaluate(this);
            if (score > highestScore)
            {
                highestScore = score;
                selected = action;
            }
        }
        bestAction = selected;
    }

    void ExecuteBestAction()
    {
        if (bestAction == null)
            return;

        string actionName = bestAction.name.Trim();
        string resultInfo = "";

        switch (actionName)
        {
            case "Hide":
                ActionHide();
                break;
            case "Stalk":
                ActionStalk();
                break;
            case "Interfere":
                resultInfo = ActionInterfere();
                break;
            case "JumpScare":
                ActionJumpScare();
                break;
        }

        Debug.Log($"AI: {actionName} ({bestAction.lastEvaluatedScore:F2})" +
            (actionName == "Interfere" ? $" -> {resultInfo}" : ""));
    }

    void ActionHide()
    {
        currentState = MonsterState.Hide;
        TeleportToDefault();
        monsterMesh.SetActive(false);
    }

    void ActionStalk()
    {
        currentState = MonsterState.Stalk;
        FindAndTeleportToSpot(MonsterSpot.SpotType.Stalking);
        monsterMesh.SetActive(true);
    }

    string ActionInterfere()
    {
        currentState = MonsterState.Interfere;
        MonsterSpot targetSpot = FindAndTeleportToSpot(MonsterSpot.SpotType.Stalking);
        string camToBreak = (targetSpot != null)
            ? targetSpot.targetCameraPoint.name
            : cameraSystem.cameraPoints[Random.Range(0, cameraSystem.cameraPoints.Length)].name;

        StartCoroutine(InterfereRoutine(camToBreak));
        return camToBreak;
    }

    void ActionJumpScare()
    {
        currentState = MonsterState.JumpScare;
        FindAndTeleportToSpot(MonsterSpot.SpotType.JumpScare);
        monsterMesh.SetActive(false);
    }

    public void ProcessQuantumHiding(Transform nextCamPoint)
    {
        MonsterSpot s = GetCurrentSpot();
        if (s == null || !monsterMesh.activeSelf)
            return;
        if (s.type == MonsterSpot.SpotType.Stalking && s.targetCameraPoint != nextCamPoint)
            if (IsVisibleFrom(nextCamPoint))
            {
                monsterMesh.SetActive(false);
                TeleportToDefault();
            }
    }

    bool IsVisibleFrom(Transform cam)
    {
        Camera c = cameraSystem.cameraSystem;
        Vector3 p = c.transform.position; Quaternion r = c.transform.rotation;
        c.transform.SetPositionAndRotation(cam.position, cam.rotation);
        Vector3 vp = c.WorldToViewportPoint(transform.position);
        bool v = vp.z > 0 && vp.x > 0 && vp.x < 1 && vp.y > 0 && vp.y < 1;
        c.transform.SetPositionAndRotation(p, r);
        return v;
    }

    void HandleQuantumHiding()
    {
        Transform currentCam = cameraSystem.GetCurrentCameraPoint();
        if (currentCam != lastCamPoint)
        {
            OnCameraSwitched(currentCam);
            lastCamPoint = currentCam;
        }

        MonsterSpot currentSpot = GetCurrentSpot();
        if (currentSpot != null &&
            currentSpot.type == MonsterSpot.SpotType.Stalking &&
            monsterMesh.activeSelf)
        {
            if (IsMonsterVisibleToPlayer() &&
                currentSpot.targetCameraPoint != currentCam)
            {
                monsterMesh.SetActive(false);
                TeleportToDefault();
            }
        }
    }

    MonsterSpot FindAndTeleportToSpot(MonsterSpot.SpotType type)
    {
        MonsterSpot bestSpot = null;
        float highestScore = -1000f;
        foreach (var spot in allSpots)
        {
            if (spot == null ||
                spot.type != type ||
                spot.targetCameraPoint == null ||
                spot.targetCameraPoint == cameraSystem.GetCurrentCameraPoint())
                continue;
            if (IsSpotVisible(spot.transform.position))
                continue;

            float dist = camper != null
                ? Vector3.Distance(spot.transform.position, camper.transform.position)
                : 100f;
            float score = 1000 / dist;
            if (score > highestScore)
            {
                highestScore = score;
                bestSpot = spot;
            }
        }
        if (bestSpot != null)
            TeleportTo(bestSpot);
        return bestSpot;
    }

    bool IsSpotVisible(Vector3 pos)
    {
        Vector3 vp = cameraSystem.cameraSystem.WorldToViewportPoint(pos);
        return vp.z > 0 && vp.x > -0.1f && vp.x < 1.1f && vp.y > -0.1f && vp.y < 1.1f;
    }

    IEnumerator InterfereRoutine(string camName)
    {
        isExecutingSpecialAction = true;
        inkManager.brokenCameraName = camName;
        yield return new WaitForSeconds(Random.Range(5f, 10f));
        inkManager.brokenCameraName = "";
        isExecutingSpecialAction = false;
    }

    public bool IsMonsterVisibleToPlayer() => GetVisibilityScore() > 0.1f;

    public float GetVisibilityScore()
    {
        if (monsterMesh == null || !monsterMesh.activeSelf)
            return 0f;
        Camera cam = playerCamera ?? Camera.main;
        Vector3 vp = cam.WorldToViewportPoint(transform.position);
        if (vp.z > 0 && vp.x > 0 && vp.x < 1 && vp.y > 0 && vp.y < 1)
        {
            if (Physics.Raycast(cam.transform.position, transform.position - cam.transform.position, out RaycastHit hit, 100f))
                if (hit.collider.gameObject != gameObject && !hit.collider.transform.IsChildOf(transform))
                    return 0f;
            return Mathf.Clamp01(1f - (Vector2.Distance(new Vector2(vp.x, vp.y), new Vector2(0.5f, 0.5f)) / 0.5f));
        }
        return 0f;
    }

    public void TeleportTo(MonsterSpot spot)
    {
        transform.position = spot.transform.position;
        transform.rotation = spot.transform.rotation;
    }

    public void TeleportToDefault()
    {
        foreach (var s in allSpots)
        {
            if (s != null && s.type == MonsterSpot.SpotType.Default)
            {
                TeleportTo(s);
                break;
            }
        }
    }

    MonsterSpot GetCurrentSpot()
    {
        foreach (var s in allSpots)
            if (s != null && Vector3.Distance(transform.position, s.transform.position) < 0.6f)
                return s;
        return null;
    }

    void OnCameraSwitched(Transform newCam)
    {
        MonsterSpot s = GetCurrentSpot();
        if (s == null)
            return;
        if (s.type == MonsterSpot.SpotType.JumpScare &&
            s.targetCameraPoint == newCam &&
            gameStateManager.timePressure > 70)
        {
            StartCoroutine(JumpScareRoutine());
        }
        else if (s.type == MonsterSpot.SpotType.Stalking &&
            IsMonsterVisibleToPlayer() &&
            s.targetCameraPoint != newCam)
        {
            monsterMesh.SetActive(false);
            TeleportToDefault();
        }
    }

    IEnumerator JumpScareRoutine()
    {
        isExecutingSpecialAction = true;
        monsterMesh.SetActive(true);
        yield return new WaitForSeconds(5f);
        monsterMesh.SetActive(false);
        TeleportToDefault();
        isExecutingSpecialAction = false;
    }
}