using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class MonsterAction
{
    public string name;
    public List<Consideration> considerations;
    [HideInInspector] public float lastEvaluatedScore;

    public float Evaluate(MonsterUtilityAI monster)
    {
        float score = 1f;
        foreach (var c in considerations)
        {
            score *= c.GetScore(monster);
            if (score <= 0) return 0;
        }

        float mod = 1f - (1f / considerations.Count);
        lastEvaluatedScore = score + ((1f - score) * mod * score);
        return lastEvaluatedScore;
    }
}