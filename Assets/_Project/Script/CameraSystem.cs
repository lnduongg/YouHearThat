using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class CameraSystem : MonoBehaviour
{
    public Transform[] cameraPoints;
    public Camera cameraSystem;

    [Header("UI Settings")]
    public TextMeshProUGUI locationText;

    [Header("Raycast")]
    public Camera playerCamera;
    public float rayDistance = 5f;
    public LayerMask screenLayer;

    public ComputerInteract computerInteract;

    public MonsterUtilityAI monsterAI;

    [ContextMenu("Preview Selected Camera")]
    void PreviewCamera()
    {
        if (cameraPoints != null && cameraPoints.Length > current)
        {
            cameraSystem.transform.position = cameraPoints[current].position;
            cameraSystem.transform.rotation = cameraPoints[current].rotation;
        }
    }

    public int current = 0;

    void Start()
    {
        MoveCamera(0);
    }

    void Update()
    {
        if (!computerInteract.isUsing) return;

        Ray ray = playerCamera.ViewportPointToRay(new Vector3(0.5f, 0.5f, 0));
        RaycastHit hit;

        Debug.DrawRay(ray.origin, ray.direction * rayDistance, Color.red);

        if (Physics.Raycast(ray, out hit, rayDistance, screenLayer))
        {
            if (Mouse.current.leftButton.wasPressedThisFrame)
            {
                current--;

                if (current < 0)
                    current = cameraPoints.Length - 1;

                if (monsterAI != null) monsterAI.ProcessQuantumHiding(cameraPoints[current]);

                MoveCamera(current);
            }

            if (Mouse.current.rightButton.wasPressedThisFrame)
            {
                current++;

                if (current >= cameraPoints.Length)
                    current = 0;

                MoveCamera(current);
            }
        }
    }

    void MoveCamera(int index)
    {
        cameraSystem.transform.SetPositionAndRotation(
            cameraPoints[index].position,
            cameraPoints[index].rotation
        );

        if (locationText != null)
        {
            locationText.text = cameraPoints[index].name;
        }
    }

    public Transform GetCurrentCameraPoint()
    {
        if (cameraPoints != null && cameraPoints.Length > 0)
        {
            return cameraPoints[current];
        }
        return null;
    }
}
