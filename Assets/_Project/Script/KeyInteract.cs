using UnityEngine;

public class KeyInteract : Interactable
{
    public enum KeyAction { Pickup, Place }

    [Header("Action Type")]
    public KeyAction actionType;

    [Header("Target Object")]
    public GameObject targetVisual;
    public InkDialogueManager inkManager;

    public override void OnFocus()
    {
        bool hasBeenPlaced = (bool)inkManager.GetInkVariable("put_key");
        if (hasBeenPlaced && actionType == KeyAction.Place)
        {
            isInteractionEnabled = false;
            if (outline != null) outline.enabled = false;
            return;
        }

        if (!isInteractionEnabled) return;

        if (actionType == KeyAction.Pickup) base.OnFocus();
        else if (actionType == KeyAction.Place)
        {
            bool hasKeyInHand = (bool)inkManager.GetInkVariable("find_key");

            if (hasKeyInHand) base.OnFocus();
        }
    }

    public override void OnInteract()
    {   
        base.OnInteract();

        if (!isInteractionEnabled) return;

        if (actionType == KeyAction.Pickup)
        {
            inkManager.SetInkVariable("find_key", true);
            if (targetVisual != null)
            {
                foreach (Renderer r in targetVisual.GetComponentsInChildren<Renderer>()) 
                    r.enabled = false;

                isInteractionEnabled = false;
            }
        }
        else if (actionType == KeyAction.Place)
        {
            bool hasKeyInHand = (bool)inkManager.GetInkVariable("find_key");

            if (hasKeyInHand)
            {
                if (targetVisual != null) targetVisual.SetActive(true);

                inkManager.SetInkVariable("put_key", true);
                inkManager.SetInkVariable("find_key", false);

                isInteractionEnabled = false;
                if (outline != null) outline.enabled = false;
            }
        }
    }
}