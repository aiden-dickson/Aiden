using UnityEngine;

/// <summary>
/// Generates simple placeholder objects at runtime
/// This is useful for testing before you have actual 3D models
/// </summary>
public class PlaceholderGenerator : MonoBehaviour
{
    public enum PlaceholderType
    {
        Character,
        Scenery
    }

    [SerializeField] private PlaceholderType type = PlaceholderType.Character;
    [SerializeField] private Color placeholderColor = Color.cyan;
    [SerializeField] private float scale = 0.3f;

    void Start()
    {
        CreatePlaceholder();
    }

    void CreatePlaceholder()
    {
        // Create a simple primitive as placeholder
        GameObject placeholder;

        if (type == PlaceholderType.Character)
        {
            // Create a capsule for characters
            placeholder = GameObject.CreatePrimitive(PrimitiveType.Capsule);
            placeholder.transform.SetParent(transform);
            placeholder.transform.localPosition = Vector3.zero;
            placeholder.transform.localScale = new Vector3(scale, scale * 1.5f, scale);

            // Add a sphere for the head
            GameObject head = GameObject.CreatePrimitive(PrimitiveType.Sphere);
            head.transform.SetParent(placeholder.transform);
            head.transform.localPosition = new Vector3(0, 0.7f, 0);
            head.transform.localScale = Vector3.one * 0.6f;
            head.GetComponent<Renderer>().material.color = placeholderColor;
        }
        else
        {
            // Create a cube for scenery
            placeholder = GameObject.CreatePrimitive(PrimitiveType.Cube);
            placeholder.transform.SetParent(transform);
            placeholder.transform.localPosition = Vector3.zero;
            placeholder.transform.localScale = Vector3.one * scale;
        }

        // Set color
        placeholder.GetComponent<Renderer>().material.color = placeholderColor;

        // Add label (optional - requires TextMeshPro in scene)
        CreateLabel(type.ToString());
    }

    void CreateLabel(string labelText)
    {
        // This creates a simple 3D text above the object
        GameObject labelObj = new GameObject("Label");
        labelObj.transform.SetParent(transform);
        labelObj.transform.localPosition = new Vector3(0, scale * 2, 0);
        labelObj.transform.localScale = Vector3.one * 0.1f;

        TextMesh textMesh = labelObj.AddComponent<TextMesh>();
        textMesh.text = labelText;
        textMesh.fontSize = 20;
        textMesh.anchor = TextAnchor.MiddleCenter;
        textMesh.alignment = TextAlignment.Center;
        textMesh.color = Color.white;
    }
}
