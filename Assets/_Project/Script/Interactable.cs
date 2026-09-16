using UnityEngine;

public class Interactable : MonoBehaviour
{
    public enum TriggerType { Distance, LookAt }
    public enum VisibilityMode { Always, ShowOnce, Never }

    [Header("Interactable Settings")]
    public string text = "Text";
    public Outline outline;
    public bool isInteractionEnabled = true;
    public AudioSource interactSound;

    [Header("Billboard Settings")]
    public TriggerType triggerBy = TriggerType.Distance;
    public VisibilityMode visibility = VisibilityMode.Always;
    public float activationDistance = 3f;
    public GameObject billboardUI;

    protected bool hasBeenSeen = false;
    protected Transform playerTransform;

    protected virtual void Start()
    {
        GameObject playerObj = GameObject.FindGameObjectWithTag("Player");
        if (playerObj != null) playerTransform = playerObj.transform;
        if (billboardUI != null) billboardUI.SetActive(false);
    }

    public virtual void OnFocus()
    {
        if (isInteractionEnabled && outline != null) outline.enabled = true;
    }
    public virtual void OnLoseFocus()
    {
        if (outline != null) outline.enabled = false;
    }
    public virtual void OnInteract()
    {
        if (interactSound != null) interactSound.Play();
    }
}