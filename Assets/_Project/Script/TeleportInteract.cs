using UnityEngine;

public class TeleportInteract : Interactable
{
    [Header("Teleport Settings")]
    public Transform targetPoint;
    public GameObject player;
    public override void OnInteract()
    {   
        base.OnInteract();
        if (!isInteractionEnabled || targetPoint == null || player == null) return;

        CharacterController cc = player.GetComponent<CharacterController>();

        if (cc != null) cc.enabled = false;

        player.transform.position = targetPoint.position;
        player.transform.rotation = targetPoint.rotation;

        Physics.SyncTransforms();

        if (cc != null) cc.enabled = true;
    }
}