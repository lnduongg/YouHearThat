using TMPro;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerInteract : MonoBehaviour
{
    public float interactDistance = 0.6f;
    public LayerMask interactLayer;

    public TextMeshProUGUI textUI;
    public ComputerInteract usingComputer;

    Interactable current;

    void Update()
    {
        Ray ray = new Ray(Camera.main.transform.position, Camera.main.transform.forward);
        RaycastHit hit;

        Interactable newInteractable = null;

        if (Physics.Raycast(ray, out hit, interactDistance, interactLayer))
        {
            Interactable[] allInteractables = hit.collider.GetComponentsInParent<Interactable>();

            foreach (Interactable inter in allInteractables)
            {
                if (inter.isInteractionEnabled)
                {
                    newInteractable = inter;
                    break;
                }
            }
        }

        if (current != newInteractable)
        {
            if (current != null) current.OnLoseFocus();
            current = newInteractable;
            if (current != null) current.OnFocus();
        }

        HandleInputs();

        UpdateUI();
    }

    void HandleInputs()
    {
        bool ePressed = Keyboard.current.eKey.wasPressedThisFrame;
        bool mouseClicked = Mouse.current.leftButton.wasPressedThisFrame ||
                        Mouse.current.rightButton.wasPressedThisFrame;

        if (usingComputer != null && usingComputer.isUsing)
        {
            if (ePressed)
            {
                usingComputer.OnInteract();
                return;
            }

            if (mouseClicked && current != null && current != usingComputer)
            {
                current.OnInteract();
                current.OnFocus();
            }
        }
        else
        {
            if (ePressed && current != null)
            {
                current.OnInteract();
            }
        }
    }

    void UpdateUI()
    {
        if (usingComputer != null && usingComputer.isUsing)
        {
            textUI.text = "";
            return;
        }

        if (current != null)
        {
            textUI.text = current.text;
        }
        else
        {
            textUI.text = "";
        }
    }
}