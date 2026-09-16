using UnityEngine;

public class BookInteract : Interactable
{
    [Header("Book Settings")]
    public string inkKnotName;
    public InkDialogueManager inkManager;

    public override void OnFocus()
    {
        if (!isInteractionEnabled) return;
        base.OnFocus();
    }

    public override void OnInteract()
    {   
        base.OnInteract();

        if (!isInteractionEnabled || inkManager == null) return;
        inkManager.StartDialogueFromKnot(inkKnotName);
    }
}