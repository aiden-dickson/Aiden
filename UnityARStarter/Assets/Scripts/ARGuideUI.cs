using UnityEngine;
using UnityEngine.UI;
using TMPro;
using UnityEngine.XR.ARFoundation;

/// <summary>
/// Manages the AR guide UI that helps users understand how to use the app
/// </summary>
public class ARGuideUI : MonoBehaviour
{
    [Header("UI References")]
    [SerializeField] private TextMeshProUGUI guideText;
    [SerializeField] private GameObject guidePanel;
    [SerializeField] private Button dismissButton;

    [Header("AR References")]
    [SerializeField] private ARPlaneManager planeManager;
    [SerializeField] private ARPlacementManager placementManager;

    [Header("Guide Messages")]
    [SerializeField] private string initialMessage = "Move your device to scan for surfaces...";
    [SerializeField] private string planeDetectedMessage = "Surface detected! Objects will appear automatically.";
    [SerializeField] private string tapToPlaceMessage = "Tap anywhere to place more objects.";

    private bool planesDetected = false;
    private float messageDisplayTime = 3f;
    private float currentMessageTime = 0f;

    void Start()
    {
        if (planeManager == null)
            planeManager = FindObjectOfType<ARPlaneManager>();

        if (placementManager == null)
            placementManager = FindObjectOfType<ARPlacementManager>();

        if (dismissButton != null)
            dismissButton.onClick.AddListener(DismissGuide);

        ShowGuide(initialMessage);
    }

    void Update()
    {
        // Check for plane detection
        if (!planesDetected && planeManager != null && planeManager.trackables.count > 0)
        {
            planesDetected = true;
            ShowGuide(planeDetectedMessage);
            Invoke(nameof(ShowTapToPlaceMessage), 3f);
        }

        // Auto-dismiss guide after some time
        if (guidePanel != null && guidePanel.activeSelf)
        {
            currentMessageTime += Time.deltaTime;
            if (currentMessageTime >= messageDisplayTime && planesDetected)
            {
                // Don't auto-dismiss the initial message
                if (guideText.text != initialMessage)
                {
                    guidePanel.SetActive(false);
                }
            }
        }
    }

    void ShowTapToPlaceMessage()
    {
        if (planesDetected)
        {
            ShowGuide(tapToPlaceMessage);
        }
    }

    /// <summary>
    /// Shows the guide with a specific message
    /// </summary>
    public void ShowGuide(string message)
    {
        if (guidePanel != null)
        {
            guidePanel.SetActive(true);
            guideText.text = message;
            currentMessageTime = 0f;
        }
    }

    /// <summary>
    /// Dismisses the guide panel
    /// </summary>
    public void DismissGuide()
    {
        if (guidePanel != null)
        {
            guidePanel.SetActive(false);
        }
    }

    /// <summary>
    /// Shows a temporary message
    /// </summary>
    public void ShowTemporaryMessage(string message, float duration = 3f)
    {
        messageDisplayTime = duration;
        ShowGuide(message);
    }
}
