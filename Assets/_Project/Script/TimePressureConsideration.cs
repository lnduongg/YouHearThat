using UnityEngine;

[CreateAssetMenu(menuName = "UtilityAI/Considerations/Time Pressure")]
public class TimePressureConsideration : Consideration
{
    protected override float GetRawValue(MonsterUtilityAI monster) =>
        monster.gameStateManager.timePressure;

    protected override float Normalize(float rawValue) => rawValue / 100f;
}