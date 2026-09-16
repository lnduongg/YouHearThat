using UnityEngine;

public abstract class Consideration : ScriptableObject
{
    public AnimationCurve responseCurve = AnimationCurve.Linear(0, 0, 1, 1);

    public float GetScore(MonsterUtilityAI monster)
    {
        float rawValue = GetRawValue(monster);
        return responseCurve.Evaluate(Mathf.Clamp01(Normalize(rawValue)));
    }

    protected abstract float GetRawValue(MonsterUtilityAI monster);
    protected abstract float Normalize(float rawValue);
}