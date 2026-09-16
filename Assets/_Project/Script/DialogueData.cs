using UnityEngine;

[CreateAssetMenu(fileName = "NewDialogue", menuName = "Dialogue/Line")]
public class DialogueData : ScriptableObject
{
    public string characterName;
    [TextArea(3, 10)] public string sentence;
    public AudioClip voiceClip;
    public float trustChange;
    public float timePressureChange;
    public WaypointNode targetNode;
    public DialogueData nextResponse;
}