using UnityEngine;

/// <summary>
/// Simple character controller for AR characters
/// Adds basic animation and interaction capabilities
/// </summary>
public class CharacterController : MonoBehaviour
{
    [Header("Animation Settings")]
    [SerializeField] private bool enableIdleAnimation = true;
    [SerializeField] private float bobSpeed = 1f;
    [SerializeField] private float bobAmount = 0.1f;
    [SerializeField] private float rotationSpeed = 30f;

    [Header("Character Info")]
    [SerializeField] private string characterName = "Character";
    [SerializeField] private string characterDescription = "An AR character";

    private Vector3 startPosition;
    private float timeOffset;

    void Start()
    {
        startPosition = transform.position;
        timeOffset = Random.Range(0f, 2f * Mathf.PI);
    }

    void Update()
    {
        if (enableIdleAnimation)
        {
            // Gentle bobbing animation
            float newY = startPosition.y + Mathf.Sin(Time.time * bobSpeed + timeOffset) * bobAmount;
            transform.position = new Vector3(transform.position.x, newY, transform.position.z);

            // Gentle rotation
            transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
        }
    }

    /// <summary>
    /// Called when character is tapped
    /// </summary>
    public void OnCharacterTapped()
    {
        Debug.Log($"Character tapped: {characterName}");
        // You can add more interaction logic here
        // For example: show UI panel, play sound, trigger animation, etc.
    }

    public string GetCharacterInfo()
    {
        return $"{characterName}: {characterDescription}";
    }
}
