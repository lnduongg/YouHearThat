using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerMovement : MonoBehaviour
{
    public float speed = 2f;
    public float mouseSensitivity = 0.025f;
    public Transform playerCamera;

    public float gravity = -9.8f;
    float yVelocity;

    float xRotation = 0f;

    public bool canMove = true;
    public bool canLook = true;
    CharacterController controller;

    void Start()
    {
        controller = GetComponent<CharacterController>();
        Cursor.lockState = CursorLockMode.Locked;
    }

    void Update()
    {
        if(canMove) Move();
        if(canLook) Look();
    }

    void Move()
    {
        float x = Keyboard.current.aKey.isPressed ? -1 :
                  Keyboard.current.dKey.isPressed ? 1 : 0;

        float z = Keyboard.current.sKey.isPressed ? -1 :
                  Keyboard.current.wKey.isPressed ? 1 : 0;

        Vector3 move = transform.right * x + transform.forward * z;

        if (controller.isGrounded && yVelocity < 0)
        {
            yVelocity = -2f;
        }

        yVelocity += gravity * Time.deltaTime;

        move.y = yVelocity;

        controller.Move(move * Time.deltaTime * speed);
    }

    void Look()
    {
        Vector2 mouseDelta = Mouse.current.delta.ReadValue();

        float mouseX = mouseDelta.x * mouseSensitivity;
        float mouseY = mouseDelta.y * mouseSensitivity;

        xRotation -= mouseY;
        xRotation = Mathf.Clamp(xRotation, -80f, 80f);

        playerCamera.localRotation = Quaternion.Euler(xRotation, 0f, 0f);
        transform.Rotate(Vector3.up * mouseX);
    }
}
