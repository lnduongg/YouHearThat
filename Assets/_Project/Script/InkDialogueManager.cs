using Ink.Runtime;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.SceneManagement;

[System.Serializable]
public struct SoundEffect
{
    public string name;
    public AudioClip clip;
}

public class InkDialogueManager : MonoBehaviour
{
    [Header("Data")]
    public TextAsset inkJSONAsset;
    private Story story;

    [Header("UI References")]
    public GameObject radioHUDPanel;
    public TextMeshProUGUI[] choiceTexts;
    public TextMeshProUGUI camperResponseText;

    [Header("Systems")]
    public GameStateManager gameStateManager;
    public CamperAI camperAI;
    public ComputerInteract computer;
    public CameraSystem cameraSystem;
    public FlashlightController camperFlashlight;
    public Camera playerCamera;
    public GameObject cameraStaticOverlay;
    public Animator screenFader;
    public GameObject badEndMonster;
    public GameObject[] allDeadBodies;

    [Header("Audio")]
    public AudioSource sfxSource;
    public SoundEffect[] sfxLibrary;

    public string brokenCameraName = "";
    private bool isWaitingForArrival, isTyping, isGameOverTriggered;
    private bool isWaitingForCam1, isWaitingForCam4, isWaitingForCam7, isWaitingForPossession;
    private bool isStaticAll = false;
    private float customWaitTime = 0f;

    void Start()
    {
        if (inkJSONAsset)
            story = new Story(inkJSONAsset.text);
        if (camperResponseText)
            camperResponseText.text = "";
        SyncVariables();
    }

    void Update()
    {
        if (story == null) return;

        string cam = cameraSystem.GetCurrentCameraPoint()?.name ?? "";

        story.variablesState["is_viewing_camper"] = (cam == "Cam11");
        story.variablesState["is_viewing_camp2"] = (cam == "Cam5");
        story.variablesState["is_viewing_cam1"] = (cam == "Cam1");
        story.variablesState["is_viewing_cam4"] = (cam == "Cam4");
        story.variablesState["is_viewing_cam7"] = (cam == "Cam7");
        story.variablesState["is_viewing_monster"] = CheckIfPlayerLookingAtMonster();
        story.variablesState["tp"] = gameStateManager.timePressure;

        if (isWaitingForCam1 && cam == "Cam1")
        {
            isWaitingForCam1 = false;
            StartDialogueFromKnot("reaction_caught_cam1");
        }
        if (isWaitingForCam4 && cam == "Cam4")
        {
            isWaitingForCam4 = false;
            StartDialogueFromKnot("reaction_possession_cam4");
        }
        if (isWaitingForCam7 && cam == "Cam7")
        {
            isWaitingForCam7 = false;
            StartDialogueFromKnot("reaction_rogue_cam7");
        }
        if (isWaitingForPossession && cam == "Cam4" && (bool)story.variablesState["is_viewing_monster"])
        {
            isWaitingForPossession = false;
            StartCoroutine(MonsterEndRoutine());
        }

        if (cameraStaticOverlay)
            cameraStaticOverlay.SetActive(isStaticAll || cam == brokenCameraName);

        bool showRadio = computer && computer.isUsing;
        if (radioHUDPanel)
            radioHUDPanel.SetActive(showRadio);
        if (showRadio)
            HandleChoiceInput();
    }

    public void ContinueStory()
    {
        if (story.canContinue)
        {
            ToggleChoices(false);
            string txt = story.Continue().Trim();
            HandleTags(story.currentTags);
            if (!isGameOverTriggered)
                StartCoroutine(DisplaySpeech(txt));
        }
        else
        {
            UpdateChoiceUI();
        }
        SyncVariables();
    }

    IEnumerator DisplaySpeech(string text)
    {
        if (string.IsNullOrEmpty(text)) yield break;
        isTyping = true;
        camperResponseText.text = "";
        float delay = Mathf.Lerp(0.03f, 0.01f, gameStateManager.timePressure / 100f);

        foreach (char c in text)
        {
            camperResponseText.text += c;
            yield return new WaitForSeconds(",.!?".Contains(c.ToString()) ? delay * 5 : delay);
        }

        yield return new WaitForSeconds(customWaitTime > 0 ? customWaitTime : Mathf.Lerp(2f, 0.8f, gameStateManager.timePressure / 100f));
        customWaitTime = 0f;
        isTyping = false;

        if (!isGameOverTriggered && !isWaitingForArrival)
        {
            if (story.canContinue)
                ContinueStory();
            else
                UpdateChoiceUI();
        }
    }

    void HandleTags(List<string> tags)
    {
        foreach (string t in tags)
        {
            string[] s = t.Split(':');
            string k = s[0].Trim();
            string v = s.Length > 1 ? s[1].Trim() : "";
            switch (k)
            {
                case "MOVE":
                    GameObject wp = GameObject.Find(v);
                    if (wp)
                    {
                        camperAI.MoveToNode(wp.GetComponent<WaypointNode>());
                        isWaitingForArrival = true;
                    }
                    break;
                case "EVENT":
                    ProcessEvent(v);
                    break;
                case "WAIT":
                    float.TryParse(v, out customWaitTime);
                    break;
                case "SFX":
                    PlaySFX(v);
                    break;
            }
        }
    }

    void ProcessEvent(string v)
    {
        if (v == "StartFlicker")
            camperFlashlight?.TriggerFlickerEvent();
        if (v == "WarningFlicker")
            camperFlashlight?.TriggerWarningFlicker();
        if (v.StartsWith("StaticCamera_"))
        {
            string n = v.Replace("StaticCamera_", "");
            if (n == "All")
                isStaticAll = true;
            else
                brokenCameraName = n;
        }
        if (v.StartsWith("ClearCamera_"))
        {
            string n = v.Replace("ClearCamera_", "");
            if (n == "All")
                isStaticAll = false;
            brokenCameraName = "";
        }
        if (v.StartsWith("DeadBody_"))
        {
            foreach (var b in allDeadBodies)
                if (b && b.name == v)
                    b.SetActive(true);
        }
        if (v == "WaitingForCam1")
            isWaitingForCam1 = true;
        if (v == "WaitingForCam4")
            isWaitingForCam4 = true;
        if (v == "WaitingForCam7")
            isWaitingForCam7 = true;
        if (v == "Monster_BadEndPos")
        {
            badEndMonster?.SetActive(true);
            isWaitingForPossession = true;
        }
        if (v == "Game_Over")
        {
            isGameOverTriggered = true;
            StartCoroutine(ReloadGameRoutine());
        }
        if (v == "Dimmed_Screen")
            screenFader?.Play("Dimmed_Screen");
        if (v == "Black_Screen")
            screenFader?.Play("Black_Screen");
        if (v == "Hide_Camper")
            camperAI.gameObject.SetActive(false);
    }

    void SyncVariables()
    {
        if (gameStateManager != null && story != null)
        {
            gameStateManager.trust = System.Convert.ToSingle(story.variablesState["trust"]);
            gameStateManager.timePressure = System.Convert.ToSingle(story.variablesState["tp"]);
        }
    }

    public void CamperReachedDestination()
    {
        if (isWaitingForArrival)
        {
            isWaitingForArrival = false;
            ContinueStory();
        }
    }

    void HandleChoiceInput()
    {
        if (isTyping || story.currentChoices.Count == 0) return;
        for (int i = 0; i < story.currentChoices.Count; i++)
        {
            if (Keyboard.current[(Key)((int)Key.Digit1 + i)].wasPressedThisFrame)
            {
                story.ChooseChoiceIndex(i);
                ContinueStory();
                break;
            }
        }
    }

    void UpdateChoiceUI()
    {
        if (isTyping) return;
        for (int i = 0; i < choiceTexts.Length; i++)
        {
            bool active = i < story.currentChoices.Count;
            choiceTexts[i].transform.parent.gameObject.SetActive(active);
            if (active)
                choiceTexts[i].text = $"[{i + 1}] {story.currentChoices[i].text}";
        }
    }

    void ToggleChoices(bool s)
    {
        foreach (var t in choiceTexts)
            if (t)
                t.transform.parent.gameObject.SetActive(s);
    }

    public void StartDialogueFromKnot(string k)
    {
        story?.ChoosePathString(k);
        ContinueStory();
    }

    public void SetInkVariable(string n, object v) => story.variablesState[n] = v;
    public object GetInkVariable(string n) => story?.variablesState[n];

    bool CheckIfPlayerLookingAtMonster()
    {
        if (!badEndMonster || !badEndMonster.activeSelf) return false;
        Vector3 vp = (playerCamera ?? Camera.main).WorldToViewportPoint(badEndMonster.transform.position);
        return vp.z > 0 && vp.x > 0.2f && vp.x < 0.8f && vp.y > 0.2f && vp.y < 0.8f;
    }

    public void PlaySFX(string n)
    {
        foreach (var s in sfxLibrary)
            if (s.name == n)
            {
                sfxSource.PlayOneShot(s.clip);
                return;
            }
    }

    IEnumerator MonsterEndRoutine()
    {
        yield return new WaitForSeconds(1f);
        StartDialogueFromKnot("possession_death_moment");
    }

    IEnumerator ReloadGameRoutine()
    {
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
        yield return new WaitForSecondsRealtime(3f);
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }
}