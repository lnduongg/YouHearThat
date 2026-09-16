using UnityEngine;

public class MonsterSpot : MonoBehaviour
{
    public enum SpotType { Default, Stalking, JumpScare }

    [Header("Spot Type")]
    public SpotType type = SpotType.Stalking;

    [Header("Camera Setup")]
    public Transform targetCameraPoint;

    private void OnDrawGizmos()
    {
        switch (type)
        {
            case SpotType.Default: Gizmos.color = Color.green; break;
            case SpotType.Stalking: Gizmos.color = Color.yellow; break;
            case SpotType.JumpScare: Gizmos.color = Color.red; break;
        }

        Gizmos.DrawWireCube(transform.position + Vector3.up, new Vector3(0.5f, 2f, 0.5f));
        Gizmos.DrawRay(transform.position + Vector3.up, transform.forward * 1f);
    }
}