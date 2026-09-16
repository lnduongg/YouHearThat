using UnityEngine;
using UnityEngine.UI;

public class UIAnimation : MonoBehaviour
{
    public Sprite[] frames;
    public float framesPerSecond = 10f;
    private Image image;

    void Awake()
    {
        image = GetComponent<Image>();
    }

    void Update()
    {
        if (frames.Length == 0) return;

        int index = (int)(Time.time * framesPerSecond) % frames.Length;
        image.sprite = frames[index];
    }
}