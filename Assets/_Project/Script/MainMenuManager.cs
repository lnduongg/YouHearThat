using UnityEngine;
using System.Collections;

public class MainMenuManager : MonoBehaviour
{
    public GameObject mainMenuCanvas;
    public Camera menuCamera;
    public GameObject playerObject;
    public Camera playerCamera;
    public Animator screenFader;
    public InkDialogueManager inkManager;
    public LampInteract ceillingLamp;
    public GameObject playerInteractionUI;

    [Header("Music Theme")]
    public AudioSource menuMusic;
    public float musicFadeTime = 1.5f;

    void Start()
    {
        mainMenuCanvas.SetActive(true);
        menuCamera.gameObject.SetActive(true);
        playerObject.SetActive(false);
        if (playerInteractionUI != null) playerInteractionUI.SetActive(false);

        menuCamera.tag = "MainCamera";
        playerCamera.tag = "Untagged";

        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }

    public void StartGame()
    {
        StartCoroutine(StartGameRoutine());
    }

    IEnumerator StartGameRoutine()
    {
        screenFader.Play("Menu_To_Black");
        StartCoroutine(FadeOutMusic());

        yield return new WaitForSeconds(1.2f);

        menuCamera.tag = "Untagged";
        menuCamera.gameObject.SetActive(false);

        playerObject.SetActive(true);
        playerCamera.tag = "MainCamera";

        Physics.SyncTransforms();

        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;

        if (playerInteractionUI != null) playerInteractionUI.SetActive(true);

        mainMenuCanvas.SetActive(false);

        if (ceillingLamp != null) ceillingLamp.SetLampState(false);

        screenFader.Play("Eye_WakeUp");

        yield return new WaitForSeconds(3f);
        if (inkManager != null)
        {
            inkManager.StartDialogueFromKnot("start_game");
        }
    }

    public void ExitGame()
    {
        StartCoroutine(ExitRoutine());
    }

    IEnumerator ExitRoutine()
    {
        if (screenFader != null) screenFader.Play("Menu_To_Black");

        yield return new WaitForSeconds(1f);

        #if UNITY_EDITOR
                UnityEditor.EditorApplication.isPlaying = false;
        #else
                    Application.Quit();
        #endif
    }

    IEnumerator FadeOutMusic()
    {
        if (menuMusic == null) yield break;

        float startVolume = menuMusic.volume;

        while (menuMusic.volume > 0)
        {
            menuMusic.volume -= startVolume * Time.deltaTime / musicFadeTime;
            yield return null;
        }

        menuMusic.Stop();
        menuMusic.volume = startVolume;
    }
}