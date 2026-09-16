using UnityEngine;

[CreateAssetMenu(menuName = "UtilityAI/Considerations/Distance")]
public class DistanceConsideration : Consideration
{
    public float maxDistance = 50f;
    protected override float GetRawValue(MonsterUtilityAI monster) =>
        Vector3.Distance(monster.transform.position, monster.camper.transform.position);

    protected override float Normalize(float rawValue) => 1 - (rawValue / maxDistance);
}