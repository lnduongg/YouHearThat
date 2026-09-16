using UnityEngine;
using TMPro;

public class LampInteract : Interactable
{
    public Light lampLight;
    public GameObject emissiveObject;
    public AudioSource switchSound;

    public bool isOn;

    protected override void Start()
    {
        base.Start();
        if (lampLight != null) isOn = lampLight.enabled;

        UpdateVisuals();
    }

    public override void OnInteract()
    {
        base.OnInteract();

        isOn = !isOn;
        if (lampLight != null) lampLight.enabled = isOn;

        UpdateVisuals();

        if (switchSound != null) switchSound.Play();
    }

    void UpdateVisuals()
    {
        UpdateEmissive();
        TextMeshProUGUI tmp = billboardUI.GetComponentInChildren<TextMeshProUGUI>();
        if (tmp != null)
        {
            tmp.text = isOn ? "Nhấn      để tắt" : "Nhấn      để bật";
        }
    }

    void UpdateEmissive() 
    {
        if (emissiveObject != null)
        {
            if (isOn) emissiveObject.GetComponent<Renderer>().material.EnableKeyword("_EMISSION");
            else emissiveObject.GetComponent<Renderer>().material.DisableKeyword("_EMISSION");
        }
    }

    public void SetLampState(bool state)
    {
        isOn = state;
        if (lampLight != null) lampLight.enabled = isOn;
        UpdateEmissive();
        UpdateVisuals();
    }
}