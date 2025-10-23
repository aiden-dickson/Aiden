using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

/// <summary>
/// Manages AR object placement using tap-to-place functionality
/// </summary>
public class ARPlacementManager : MonoBehaviour
{
    [Header("AR Components")]
    [SerializeField] private ARRaycastManager raycastManager;
    [SerializeField] private ARPlaneManager planeManager;

    [Header("Prefabs to Place")]
    [SerializeField] private GameObject[] characterPrefabs;
    [SerializeField] private GameObject[] sceneryPrefabs;

    [Header("Settings")]
    [SerializeField] private bool autoPlaceOnStart = false;
    [SerializeField] private float autoPlaceDelay = 2f;

    private List<ARRaycastHit> hits = new List<ARRaycastHit>();
    private List<GameObject> spawnedObjects = new List<GameObject>();
    private bool hasPlacedInitialObjects = false;

    void Start()
    {
        if (raycastManager == null)
            raycastManager = FindObjectOfType<ARRaycastManager>();

        if (planeManager == null)
            planeManager = FindObjectOfType<ARPlaneManager>();

        if (autoPlaceOnStart)
        {
            Invoke(nameof(AutoPlaceObjects), autoPlaceDelay);
        }
    }

    void Update()
    {
        // Handle touch input for manual placement
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {
                PlaceObjectAtTouch(touch.position);
            }
        }

        // Auto-place when planes are detected
        if (autoPlaceOnStart && !hasPlacedInitialObjects && planeManager.trackables.count > 0)
        {
            AutoPlaceObjects();
            hasPlacedInitialObjects = true;
        }
    }

    /// <summary>
    /// Places an object at the touch position if a plane is detected
    /// </summary>
    void PlaceObjectAtTouch(Vector2 touchPosition)
    {
        if (raycastManager.Raycast(touchPosition, hits, TrackableType.PlaneWithinPolygon))
        {
            Pose hitPose = hits[0].pose;

            // Randomly choose between character and scenery
            GameObject prefabToPlace = Random.value > 0.5f ? GetRandomCharacter() : GetRandomScenery();

            if (prefabToPlace != null)
            {
                GameObject spawnedObject = Instantiate(prefabToPlace, hitPose.position, hitPose.rotation);
                spawnedObjects.Add(spawnedObject);
            }
        }
    }

    /// <summary>
    /// Automatically places objects when planes are detected
    /// </summary>
    void AutoPlaceObjects()
    {
        if (planeManager.trackables.count == 0) return;

        // Get the first detected plane
        var plane = planeManager.trackables[0];
        Vector3 planeCenter = plane.center;

        // Place characters
        for (int i = 0; i < Mathf.Min(2, characterPrefabs.Length); i++)
        {
            Vector3 offset = new Vector3(Random.Range(-0.5f, 0.5f), 0, Random.Range(-0.5f, 0.5f));
            Vector3 spawnPosition = planeCenter + offset;
            GameObject character = Instantiate(characterPrefabs[i % characterPrefabs.Length], spawnPosition, Quaternion.identity);
            spawnedObjects.Add(character);
        }

        // Place scenery
        for (int i = 0; i < Mathf.Min(3, sceneryPrefabs.Length); i++)
        {
            Vector3 offset = new Vector3(Random.Range(-1f, 1f), 0, Random.Range(-1f, 1f));
            Vector3 spawnPosition = planeCenter + offset;
            GameObject scenery = Instantiate(sceneryPrefabs[i % sceneryPrefabs.Length], spawnPosition, Quaternion.identity);
            spawnedObjects.Add(scenery);
        }
    }

    /// <summary>
    /// Clears all spawned objects
    /// </summary>
    public void ClearAllObjects()
    {
        foreach (GameObject obj in spawnedObjects)
        {
            if (obj != null)
                Destroy(obj);
        }
        spawnedObjects.Clear();
        hasPlacedInitialObjects = false;
    }

    GameObject GetRandomCharacter()
    {
        return characterPrefabs.Length > 0 ? characterPrefabs[Random.Range(0, characterPrefabs.Length)] : null;
    }

    GameObject GetRandomScenery()
    {
        return sceneryPrefabs.Length > 0 ? sceneryPrefabs[Random.Range(0, sceneryPrefabs.Length)] : null;
    }
}
