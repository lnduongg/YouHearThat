using UnityEngine;

[CreateAssetMenu(menuName = "UtilityAI/Considerations/Visibility")]
public class VisibilityConsideration : Consideration
{
    protected override float GetRawValue(MonsterUtilityAI monster)
    {
        return monster.IsMonsterVisibleToPlayer() ? 1f : 0f;
    }
    protected override float Normalize(float rawValue) => rawValue;
}