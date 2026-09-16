using UnityEngine;

public class ShowWaypoints : MonoBehaviour
{
    public float size = 1f;
    public Color color = Color.yellow;

    void OnDrawGizmos()
    {
        Gizmos.color = color;
        Gizmos.DrawSphere(transform.position, size);

#if UNITY_EDITOR
        UnityEditor.Handles.Label(transform.position + Vector3.up * size, gameObject.name);
#endif
    }
}