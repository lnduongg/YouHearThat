using UnityEngine;

public class GameStateManager : MonoBehaviour
{
    [Header("Core Stats")]
    [Range(0, 100)] public float trust = 50f;         
    [Range(0, 100)] public float timePressure = 0f;
    public float timePressureIncrease = 0.05f;
    public InkDialogueManager inkDialogueManager;
    private bool badEndingTriggered = false;
    public enum Mood { Calm, Nervous, Panicked }

    void Update()
    {
        AddTimePressure(timePressureIncrease * Time.deltaTime);

        if (timePressure >= 100 && !badEndingTriggered)
        {
            badEndingTriggered = true;
            inkDialogueManager.StartDialogueFromKnot("bad_ending_possession");
        }
    }

    public Mood GetCurrentMood()
    {
        if (timePressure > 75) return Mood.Panicked;
        if (timePressure > 40) return Mood.Nervous;
        return Mood.Calm;
    }

    public void AddTrust(float amount) 
    { 
        trust = Mathf.Clamp(trust + amount, 0, 100); 
    }
    public void AddTimePressure(float amount) 
    { 
        timePressure = Mathf.Clamp(timePressure + amount, 0, 100); 
    }
}