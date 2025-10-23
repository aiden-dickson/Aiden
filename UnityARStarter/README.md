# Unity AR Starter Project

A complete augmented reality starter project for Unity that allows you to view characters and scenery through your phone camera. This project is designed to work on mobile devices and can be extended to support AR headsets.

## Features

- **AR Foundation Support**: Built with Unity's AR Foundation for cross-platform AR development
- **Character Placement**: View animated AR characters in your space
- **Scenery System**: Random scenery objects (trees, rocks, bushes) that populate the AR environment
- **Interactive Guide**: Built-in user guide that helps users understand how to use the app
- **Tap-to-Place**: Place additional objects by tapping on detected surfaces
- **Auto-Placement**: Automatically places objects when a surface is detected
- **Placeholder System**: Includes procedural placeholder objects for testing before adding custom 3D models

## Requirements

### Unity Version
- Unity 2022.3.10f1 or later (LTS recommended)

### Supported Platforms
- iOS 11.0+ (ARKit)
- Android 7.0+ (ARCore)

### Required Packages
The following packages are included in the manifest:
- AR Foundation 5.1.0
- ARCore XR Plugin 5.1.0
- ARKit XR Plugin 5.1.0
- XR Plugin Management 4.4.0
- Universal Render Pipeline 14.0.9
- TextMeshPro 3.0.6

## Project Structure

```
UnityARStarter/
├── Assets/
│   ├── Scenes/
│   │   └── ARScene.unity          # Main AR scene
│   ├── Scripts/
│   │   ├── ARPlacementManager.cs  # Handles object placement in AR
│   │   ├── CharacterController.cs # Character behavior and animation
│   │   ├── SceneryObject.cs       # Scenery object behavior
│   │   ├── ARGuideUI.cs           # User guide system
│   │   └── PlaceholderGenerator.cs # Creates placeholder objects
│   ├── Prefabs/
│   │   ├── Character1.prefab      # Hero character
│   │   ├── Character2.prefab      # Companion character
│   │   ├── Tree.prefab            # Tree scenery
│   │   ├── Rock.prefab            # Rock scenery
│   │   └── Bush.prefab            # Bush scenery
│   └── Materials/                 # Materials (create as needed)
├── ProjectSettings/               # Unity project settings
└── Packages/
    └── manifest.json              # Package dependencies
```

## Setup Instructions

### 1. Import into Unity

1. Open Unity Hub
2. Click "Add" and select the `UnityARStarter` folder
3. Open the project with Unity 2022.3.10f1 or later

### 2. Configure XR Plugin Management

1. Go to **Edit > Project Settings > XR Plugin Management**
2. Install XR Plugin Management if prompted
3. Enable the following plugins:
   - **For iOS builds**: Enable "ARKit"
   - **For Android builds**: Enable "ARCore"

### 3. Configure Build Settings

#### For iOS:
1. Go to **File > Build Settings**
2. Switch platform to **iOS**
3. Go to **Player Settings**
4. Set the following:
   - **Bundle Identifier**: com.yourcompany.arstarter
   - **Target minimum iOS Version**: 11.0 or higher
   - **Camera Usage Description**: "This app uses the camera for augmented reality"
   - **Architecture**: ARM64

#### For Android:
1. Go to **File > Build Settings**
2. Switch platform to **Android**
3. Go to **Player Settings**
4. Set the following:
   - **Package Name**: com.yourcompany.arstarter
   - **Minimum API Level**: Android 7.0 'Nougat' (API level 24) or higher
   - **Target API Level**: Latest
   - Under **XR Settings**, ensure ARCore is enabled

### 4. Build and Deploy

#### iOS:
1. Connect your iOS device
2. Click **Build and Run**
3. Open the generated Xcode project
4. Sign with your Apple Developer account
5. Deploy to your device

#### Android:
1. Enable Developer Mode and USB Debugging on your Android device
2. Connect your device via USB
3. Click **Build and Run**
4. The APK will be built and installed automatically

## How to Use

### Running the App

1. Launch the app on your AR-capable device
2. Move your phone slowly to scan for flat surfaces (floor, table, etc.)
3. When a surface is detected, the guide will notify you
4. Characters and scenery will automatically appear on the detected surface
5. Tap anywhere on a detected surface to place additional objects

### User Interface

- **Guide Panel**: Shows instructions and tips
  - "Move your device to scan for surfaces..."
  - "Surface detected! Objects will appear automatically."
  - "Tap anywhere to place more objects."

## Customization

### Adding Your Own 3D Models

The project uses placeholder objects by default. To add your own 3D models:

1. Import your 3D models into the `Assets/` folder
2. Create new prefabs from your models in `Assets/Prefabs/`
3. Add the appropriate script components:
   - For characters: Add `CharacterController.cs`
   - For scenery: Add `SceneryObject.cs`
4. Update the prefab references in the AR Scene:
   - Select "AR Session Origin" in the Hierarchy
   - In the Inspector, find the `ARPlacementManager` component
   - Assign your new prefabs to the `Character Prefabs` or `Scenery Prefabs` arrays

### Modifying Character Behavior

Edit `CharacterController.cs` to customize:
- Animation speed and style
- Character information
- Interaction responses

### Modifying Placement Behavior

Edit `ARPlacementManager.cs` to customize:
- Auto-placement timing
- Number of objects spawned
- Placement positions and patterns

### Customizing the Guide

Edit `ARGuideUI.cs` to customize:
- Guide messages
- Display duration
- UI appearance

## Scripts Overview

### ARPlacementManager.cs
Manages the placement of AR objects on detected planes. Handles both automatic placement when surfaces are detected and manual tap-to-place functionality.

**Key Features:**
- Raycast-based placement
- Auto-placement on surface detection
- Random object selection
- Object management (spawn/clear)

### CharacterController.cs
Controls character behavior including idle animations and interactions.

**Key Features:**
- Gentle bobbing animation
- Rotation animation
- Character information storage
- Tap interaction handling

### SceneryObject.cs
Simple component for scenery objects with optional rotation animation.

### ARGuideUI.cs
Manages the user interface guide system that helps users understand how to interact with the AR experience.

**Key Features:**
- Context-aware messages
- Automatic message progression
- Surface detection feedback

### PlaceholderGenerator.cs
Generates simple 3D primitive placeholders at runtime for testing before custom models are added.

**Key Features:**
- Creates capsules for characters
- Creates cubes for scenery
- Adds text labels
- Customizable colors and scales

## Troubleshooting

### AR Session doesn't start
- Ensure your device supports ARCore (Android) or ARKit (iOS)
- Check that camera permissions are granted
- Verify XR Plugin Management is properly configured

### Objects don't appear
- Make sure you're moving the device to detect surfaces
- Check that there's adequate lighting
- Ensure the surface is flat and has texture

### Build errors
- Verify all required packages are installed
- Check that the correct platform (iOS/Android) is selected
- Ensure API levels meet minimum requirements

### Performance issues
- Reduce the number of spawned objects
- Optimize 3D models (reduce polygon count)
- Use simpler materials and shaders

## Future Enhancements

This starter project can be extended with:

- **Headset Support**: Add support for AR headsets like HoloLens or Magic Leap
- **Multiplayer**: Implement shared AR experiences using Unity Netcode
- **Occlusion**: Add depth-based occlusion for more realistic AR
- **Gesture Recognition**: Implement gestures for object manipulation
- **Persistent AR**: Save and load AR object positions across sessions
- **Custom UI**: Add more interactive UI elements and controls
- **Sound Effects**: Add spatial audio for characters and scenery
- **Advanced Animations**: Replace placeholder objects with fully animated 3D models
- **Light Estimation**: Adjust object lighting based on real-world lighting
- **Cloud Anchors**: Share AR experiences across multiple devices

## Resources

- [Unity AR Foundation Documentation](https://docs.unity3d.com/Packages/com.unity.xr.arfoundation@5.1/manual/index.html)
- [ARCore Documentation](https://developers.google.com/ar)
- [ARKit Documentation](https://developer.apple.com/augmented-reality/)
- [Unity Learn - AR Development](https://learn.unity.com/course/augmented-reality)

## License

This is a starter template project. Feel free to use it as the foundation for your own AR projects.

## Notes

- The placeholder system uses Unity primitives (capsules, cubes, spheres) to create simple visual representations
- Replace placeholder objects with your own 3D models for production use
- Test on actual devices - AR features don't work in the Unity Editor
- Ensure adequate lighting and textured surfaces for best AR tracking results

---

**Created for AR development on mobile devices with future headset support in mind.**
