using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class ComputerScreenInteract : Interactable
{
    [Header("Screen UI Settings")]
    public GameObject mouseHintUI;   
    public TextMeshProUGUI hintText;
    public GameObject mapObject;
    public InkDialogueManager inkManager;
    private bool isLookingAtScreen = false;
    private bool isMapOpen = false;

    protected override void Start()
    {
        base.Start();

        if (mouseHintUI != null) mouseHintUI.SetActive(false);
        if (mapObject != null) mapObject.SetActive(false);
        if (hintText != null) hintText.text = "Mở Map";
        isMapOpen = false;
    }

    void Update()
    {
        bool isCameraBroken = false;

        if (inkManager != null && inkManager.cameraStaticOverlay != null)
            isCameraBroken = inkManager.cameraStaticOverlay.activeSelf;

        if (isCameraBroken)
        {
            if (mouseHintUI != null && mouseHintUI.activeSelf) mouseHintUI.SetActive(false);
            return;
        }

        if (isLookingAtScreen)
        {
            if (mouseHintUI != null && !mouseHintUI.activeSelf) mouseHintUI.SetActive(true);
            if (Keyboard.current.mKey.wasPressedThisFrame) ToggleMap();
        }
    }

    public override void OnFocus()
    {
        if (!isInteractionEnabled) return;

        isLookingAtScreen = true;

        if (mouseHintUI != null)
        {
            mouseHintUI.SetActive(true);
        }
    }

    private void ToggleMap()
    {
        isMapOpen = !isMapOpen;
        if (mapObject != null) mapObject.SetActive(isMapOpen);

        if (hintText != null) hintText.text = isMapOpen ? "Tắt Map" : "Mở Map";
    }

    public override void OnLoseFocus()
    {
        isLookingAtScreen = false;
        if (mouseHintUI != null) mouseHintUI.SetActive(false);
        base.OnLoseFocus();
    }

    public override void OnInteract()
    {
        base.OnInteract();
    }
}