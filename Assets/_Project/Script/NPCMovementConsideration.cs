using UnityEngine;

[CreateAssetMenu(menuName = "UtilityAI/Considerations/NPC Movement")]
public class NPCMovementConsideration : Consideration
{
    protected override float GetRawValue(MonsterUtilityAI monster)
    {
        return monster.GetVisibilityScore();
    }

    protected override float Normalize(float rawValue) => rawValue;
}