using UnityEngine;

public class WaypointNode : MonoBehaviour
{
    public string locationName;
    public WaypointNode[] neighbors;
    [Header("Radio Menu")]
    public DialogueData[] availablePlayerCommands;

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.yellow;
        Gizmos.DrawSphere(transform.position, 0.5f);
        if (neighbors == null) return;
        foreach (var node in neighbors)
        {
            if (node != null)
                Gizmos.DrawLine(transform.position, node.transform.position);
        }
    }
}