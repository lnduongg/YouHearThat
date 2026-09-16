using UnityEngine;

[CreateAssetMenu(menuName = "UtilityAI/Considerations/Randomness")]
public class UnpredictableConsideration : Consideration
{
    protected override float GetRawValue(MonsterUtilityAI monster) => Random.value;
    protected override float Normalize(float rawValue) => rawValue;
}