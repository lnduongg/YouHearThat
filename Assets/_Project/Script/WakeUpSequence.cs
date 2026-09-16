using UnityEngine;
using System.Collections;

public class WakeUpSequence : MonoBehaviour
{
    public GameObject player;
    public Camera playerCamera;
    public PlayerMovement movementScript;
    public PlayerInteract interactScript;

    [Header("Position")]
    public Transform startPoint;
    public Transform standingPoint;

    [Header("Settings")]
    public float wakeUpDuration = 3.0f;
    public AnimationCurve curve = AnimationCurve.EaseInOut(0, 0, 1, 1);
    public Animator screenFader;

    void Start()
    {
        StartCoroutine(StartWakeUp());
    }

    IEnumerator StartWakeUp()
    {

        CharacterController cc = player.GetComponent<CharacterController>();
        if (cc != null) cc.enabled = false;
        movementScript.enabled = false;
        interactScript.enabled = false;

        player.transform.position = startPoint.position;
        playerCamera.transform.rotation = startPoint.rotation;

        yield return new WaitForSeconds(1.0f);

        float elapsed = 0;
        Vector3 startPos = startPoint.position;
        Quaternion startRot = startPoint.rotation;

        while (elapsed < wakeUpDuration)
        {
            elapsed += Time.deltaTime;
            float percent = curve.Evaluate(elapsed / wakeUpDuration);

            player.transform.position = Vector3.Lerp(startPos, standingPoint.position, percent);
            playerCamera.transform.rotation = Quaternion.Slerp(startRot, standingPoint.rotation, percent);

            yield return null;
        }

        player.transform.position = standingPoint.position;
        playerCamera.transform.localRotation = Quaternion.identity;

        if (cc != null) cc.enabled = true;
        movementScript.enabled = true;
        interactScript.enabled = true;
    }
}