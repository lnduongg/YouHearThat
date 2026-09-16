using UnityEngine;
using UnityEngine.InputSystem;

public class ComputerInteract : Interactable
{
    [Header("Computer Settings")]
    public Transform sitPoint;
    public Transform cameraPoint;
    public Transform exitPoint;
    public GameObject player;
    public Camera playerCamera;
    public PlayerMovement playerMovement;
    public GameObject interactUI;

    float startYRotation;
    public float rotationLimit = 90f;
    public bool isUsing = false;

    private CharacterController charController;

    [Header("Sub Interactions")]
    public Interactable[] subObjects;

    protected override void Start()
    {
        base.Start();
        charController = player.GetComponent<CharacterController>();
    }

    public override void OnInteract()
    {
        if (isUsing) ExitComputer();
        else EnterComputer();
    }

    void Update()
    {
        if (!isUsing) return;

        float currentY = player.transform.eulerAngles.y;
        float deltaAngle = Mathf.DeltaAngle(startYRotation, currentY);
        float clampedY = Mathf.Clamp(deltaAngle, -rotationLimit, rotationLimit);

        player.transform.rotation = Quaternion.Euler(0, startYRotation + clampedY, 0);
    }

    public override void OnFocus()
    {
        if (isUsing) return;

        base.OnFocus();
    }

    void EnterComputer()
    {
        isUsing = true;
        isInteractionEnabled = false;

        PlayerInteract pi = FindFirstObjectByType<PlayerInteract>();
        if (pi != null) pi.interactDistance = 0.8f;

        SetLayerRecursively(gameObject, LayerMask.NameToLayer("Default"));

        if (charController != null) charController.enabled = false;

        player.transform.position = sitPoint.position;
        player.transform.rotation = sitPoint.rotation;

        playerMovement.canMove = false;
        playerMovement.canLook = true;

        Physics.SyncTransforms();

        FindFirstObjectByType<PlayerInteract>().usingComputer = this;

        playerCamera.transform.position = cameraPoint.position;
        playerCamera.transform.rotation = cameraPoint.rotation;

        startYRotation = player.transform.eulerAngles.y;

        foreach (var obj in subObjects) if (obj != null) obj.isInteractionEnabled = true;

        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;

    }

    void ExitComputer()
    {
        isUsing = false;
        isInteractionEnabled = true;

        PlayerInteract pi = FindFirstObjectByType<PlayerInteract>();
        if (pi != null) pi.interactDistance = 0.6f;

        SetLayerRecursively(gameObject, LayerMask.NameToLayer("Interactable"));

        foreach (var obj in subObjects)
        {
            if (obj != null)
            {
                obj.isInteractionEnabled = false;
                obj.OnLoseFocus();
            }
        }

        player.transform.position = exitPoint.position;
        player.transform.rotation = exitPoint.rotation;

        Physics.SyncTransforms();

        if (charController != null) charController.enabled = true;

        playerMovement.canMove = true;
        playerMovement.canLook = true;

        FindFirstObjectByType<PlayerInteract>().usingComputer = null;

        // Reset camera
        playerCamera.transform.localPosition = new Vector3(0, 0.7f, 0);
        playerCamera.transform.localRotation = Quaternion.identity;

        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }
    void SetLayerRecursively(GameObject obj, int newLayer)
    {
        if (obj == null) return;
        obj.layer = newLayer;

        foreach (Transform child in obj.transform)
        {
            if (child == null) continue;
            SetLayerRecursively(child.gameObject, newLayer);
        }
    }
}
