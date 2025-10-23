using UnityEngine;

/// <summary>
/// Simple scenery object that can have basic behaviors
/// </summary>
public class SceneryObject : MonoBehaviour
{
    [Header("Scenery Settings")]
    [SerializeField] private string sceneryName = "Scenery";
    [SerializeField] private bool enableAnimation = false;
    [SerializeField] private float rotationSpeed = 10f;

    void Update()
    {
        if (enableAnimation)
        {
            transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
        }
    }
}
