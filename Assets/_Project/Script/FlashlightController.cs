using UnityEngine;
using System.Collections;

public class FlashlightController : MonoBehaviour
{
    private Light lightComp;

    [Header("Flicker")]
    public bool isConstantFlicker = false;
    [Range(0f, 1f)] public float flickerChance = 0.95f;

    void Awake()
    {
        lightComp = GetComponentInChildren<Light>();
    }

    void Update()
    {
        if (isConstantFlicker && lightComp != null)
        {
            if (Random.value > flickerChance)
            {
                lightComp.enabled = !lightComp.enabled;
            }
        }
    }

    public void TriggerFlickerEvent()
    {
        isConstantFlicker = false;
        StartCoroutine(FlickerThenDie());
    }

    IEnumerator FlickerThenDie()
    {
        float endTime = Time.time + 3f;

        while (Time.time < endTime)
        {
            lightComp.enabled = !lightComp.enabled;
            yield return new WaitForSeconds(Random.Range(0.05f, 0.2f));
        }

        lightComp.enabled = false;
    }
    public void TriggerWarningFlicker()
    {
        StartCoroutine(FlickerOnly(2f));
    }

    IEnumerator FlickerOnly(float duration)
    {
        float endTime = Time.time + duration;
        while (Time.time < endTime)
        {
            lightComp.enabled = !lightComp.enabled;
            yield return new WaitForSeconds(Random.Range(0.05f, 0.1f));
        }
        lightComp.enabled = true;
    }
}