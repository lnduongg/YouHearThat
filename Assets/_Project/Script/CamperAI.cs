using UnityEngine;
using UnityEngine.AI;

public class CamperAI : MonoBehaviour
{
    public WaypointNode currentNode; 
    private NavMeshAgent agent;
    private Animator anim;
    public bool isMovingToNode = false;

    void Start()
    {
        agent = GetComponent<NavMeshAgent>();
        anim = GetComponent<Animator>();
        if (currentNode == null) UpdateCurrentNode();
    }

    void Update()
    {
        float currentSpeed = agent.velocity.magnitude;
        anim.SetFloat("Speed", currentSpeed);

        if (isMovingToNode && !agent.pathPending && agent.remainingDistance <= agent.stoppingDistance)
        {
            isMovingToNode = false;
            FindFirstObjectByType<InkDialogueManager>().CamperReachedDestination();
        }

        float timePressure = FindFirstObjectByType<GameStateManager>().timePressure;
        agent.speed = (timePressure > 70) ? 5f : 2.5f;
    }

    public void MoveToNode(WaypointNode targetNode)
    {
        if (agent != null && targetNode != null)
        {
            agent.SetDestination(targetNode.transform.position);
            currentNode = targetNode;
            isMovingToNode = true;
            Debug.Log("Camper ở " + targetNode.locationName);
        }
    }

    void UpdateCurrentNode() {  }
}