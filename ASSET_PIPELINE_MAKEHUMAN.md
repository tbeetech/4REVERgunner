# MakeHuman to Blender to Godot Asset Pipeline

This guide walks you through creating a custom character in MakeHuman, refining it in Blender, and importing it into Godot 4.

## Prerequisites

- **MakeHuman** - Download from [makehumancommunity.org](http://www.makehumancommunity.org/)
- **Blender 3.0+** - Download from [blender.org](https://www.blender.org/)
- **Godot 4** - Already installed

## Part 1: Creating Character in MakeHuman

### Step 1: Launch MakeHuman
1. Open MakeHuman
2. You'll see a default human character

### Step 2: Customize the Character
1. **Modeling Tab** (left sidebar):
   - Adjust body proportions (gender, age, muscle, weight)
   - Use sliders to customize
   
2. **Geometries Tab**:
   - Add clothes, hair, teeth, eyes
   - Browse the library and click items to apply
   
3. **Materials Tab**:
   - Choose skin texture and color
   - Adjust eyes, hair color
   
4. **Pose/Animate Tab** (optional):
   - Apply a base pose
   - For rigged characters, use skeleton presets

### Step 3: Export from MakeHuman
1. Go to **Files → Export**
2. **Important settings**:
   - **Mesh Format**: Choose **Collada (dae)** or **FBX**
     - Collada is more reliable for Blender
   - **Scale Units**: 1.0 (default)
   - **Feet on Ground**: Checked
   - **Binary**: Unchecked (for Collada)
3. **Options to enable**:
   - ☑ Skeleton (if you want animation)
   - ☑ Rig (skeleton with bones)
   - ☑ Include normals
   - ☑ Include textures
4. Click **Export**
5. Save as `character_name.dae` in a working folder (NOT your Godot project yet)

### Troubleshooting MakeHuman
- **Character looks wrong**: Reset with File → New
- **Export disabled**: Make sure a mesh format is selected
- **Missing features**: Update to latest MakeHuman Community version

## Part 2: Refining in Blender

### Step 1: Import to Blender
1. Open Blender (start with default scene or File → New → General)
2. Delete default objects if desired (select with mouse, press **X**, confirm)
3. **File → Import → Collada (.dae)** (or FBX if you exported that)
4. Navigate to your exported MakeHuman file
5. Click **Import COLLADA** or **Import FBX**

### Step 2: Inspect the Character
1. The character should appear in the viewport
2. **Zoom**: Scroll mouse wheel
3. **Rotate view**: Middle-mouse drag
4. **Pan view**: Shift + Middle-mouse drag
5. Check that skeleton (armature) is present if you exported it

### Step 3: Clean Up (Optional)
1. Select the character mesh (left-click)
2. Tab into **Edit Mode** (or press Tab)
3. Fix any mesh issues:
   - Remove unnecessary vertices
   - Clean up UV maps if needed
4. Tab back to **Object Mode**

### Step 4: Apply Materials
1. Switch to **Shading** workspace (top tabs)
2. Select the character mesh
3. In the **Shader Editor** (bottom half):
   - You should see material nodes from MakeHuman
   - Adjust colors, roughness, metallic as desired
4. **Optional**: Add textures:
   - Add **Image Texture** node
   - Connect to **Base Color** of Principled BSDF
   - Load your texture file

### Step 5: Set Up for Godot
1. **Check scale**: Character should be reasonable size (1-2 Blender units tall)
2. **Check orientation**: Character should face forward (-Y in Blender = -Z in Godot)
3. **Apply transforms**:
   - Select all objects (character + armature if present)
   - **Object → Apply → All Transforms**
4. **Rename** (optional):
   - Select character mesh in Outliner (top-right)
   - Rename to something clear like "CharacterMesh"

### Step 6: Export as glTF for Godot
1. **File → Export → glTF 2.0 (.glb/.gltf)**
2. **Important settings**:
   - **Format**: **glTF Binary (.glb)** (single file, easier)
   - **Include**:
     - ☑ Selected Objects (if only character selected) OR ☑ Visible Objects
     - ☑ Cameras (uncheck if you don't want cameras)
     - ☑ Punctual Lights (uncheck if you don't want lights)
   - **Transform**:
     - ☑ **+Y Up** (VERY IMPORTANT for Godot!)
   - **Geometry**:
     - ☑ Apply Modifiers
     - ☑ UVs
     - ☑ Normals
     - ☑ Vertex Colors (if used)
   - **Animation** (if rigged):
     - ☑ Animation (if you have animations)
     - ☑ Skinning (MUST be checked if rigged)
3. Navigate to your Godot project folder, save in `models/` or `assets/` folder
4. Name it clearly: `character_main.glb`
5. Click **Export glTF 2.0**

### Troubleshooting Blender
- **Character too small/large in Godot**: Adjust scale in Blender before export
- **Character rotated wrong**: Check +Y Up in export settings
- **Missing textures**: Make sure texture files are in the same folder or embedded in .glb
- **Animations not working**: Make sure "Skinning" was checked in glTF export

## Part 3: Importing to Godot 4

### Step 1: Import the File
1. Open your Godot project
2. In the **FileSystem** dock (bottom-left), navigate to where you saved the .glb file
3. Godot will automatically detect and import it
4. Wait for import to finish (progress bar in bottom-right)

### Step 2: Inspect the Import
1. Click on the .glb file in FileSystem
2. In the **Import** dock (left side), you'll see import options:
   - **Root Type**: Usually Node3D or AnimationPlayer
   - **Root Name**: Name of the root node
3. Usually defaults are fine, but you can adjust:
   - **Meshes → Storage**: Choose **Mesh** for better performance
   - **Animation → FPS**: Set to 30 if you have animations

### Step 3: Use in a Scene
1. Drag the .glb file from FileSystem into your scene (or click the "Instantiate Child Scene" button)
2. It will create a node hierarchy with your character
3. **OR** create a new scene:
   - **Scene → New Scene**
   - Right-click root → **Instantiate Child Scene**
   - Select your .glb file

### Step 4: Replace Placeholder
1. Open `scenes/player_placeholder.tscn`
2. Find the **MeshInstance3D** node with the BoxMesh
3. Delete it (or keep as backup)
4. Add your character:
   - Right-click on **CharacterBody3D** (root)
   - **Add Child Node → MeshInstance3D** (or drag .glb as child)
   - Set the mesh property to your imported character
5. Adjust **Transform** if needed:
   - Position, Rotation, Scale in the Inspector
6. Save the scene (Ctrl+S)

### Step 5: Test
1. Run the main scene (F5)
2. Check that your character appears correctly
3. Test movement (arrow keys)
4. Check console for errors (View → Toggle Bottom Panel)

### Troubleshooting Godot
- **Character not visible**: Check camera position, character scale
- **Character is black**: Add lights to your scene (DirectionalLight3D)
- **Character floating/underground**: Adjust Y position in Transform
- **Animations not playing**: Check AnimationPlayer node, ensure animations imported
- **Console errors**: Check file paths, ensure .glb imported successfully

## Common Issues & Solutions

### Issue: Character has no texture in Godot
**Solution**: 
- Make sure textures were embedded in .glb or are in same folder
- In Godot, check the material on the MeshInstance3D
- Re-export from Blender with textures embedded

### Issue: Character is rotated 90 degrees
**Solution**: 
- Make sure you checked "+Y Up" in Blender glTF export
- In Godot, you can rotate the character node as workaround

### Issue: Character is too small/large
**Solution**: 
- In Godot, select the character node
- Adjust **Scale** in Transform (try 0.5 or 2.0)
- OR re-export from Blender at correct scale

### Issue: Bones/armature visible in game
**Solution**: 
- In Godot, find the Skeleton3D node
- Uncheck **Visible** in the Inspector

## Tips & Best Practices

1. **Start simple**: Get a basic character working before adding complexity
2. **Consistent scale**: Keep characters around 1-2 units tall in Blender
3. **Optimize meshes**: Lower poly count for better performance (simplify in Blender)
4. **Test early**: Import to Godot frequently to catch issues early
5. **Version control**: Save incremental Blender files (character_v1.blend, character_v2.blend)
6. **File organization**:
   ```
   godot_project/
   ├── models/
   │   ├── character_main.glb
   │   └── character_enemy.glb
   ├── textures/
   │   └── character_diffuse.png
   └── scenes/
       └── player.tscn
   ```

## Additional Resources

- **MakeHuman Docs**: [makehumancommunity.org/wiki](http://www.makehumancommunity.org/wiki)
- **Blender Manual**: [docs.blender.org](https://docs.blender.org/)
- **Godot 3D Import**: [docs.godotengine.org - Importing 3D Scenes](https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/index.html)
- **glTF in Godot**: [docs.godotengine.org - glTF](https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/gltf.html)

## Quick Reference: Export Settings

### MakeHuman
- Format: Collada (DAE) or FBX
- Scale: 1.0
- Include: Skeleton, Rig

### Blender → Godot
- Format: glTF Binary (.glb)
- Transform: +Y Up ✓
- Include: Skinning ✓ (if rigged)
- Geometry: Apply Modifiers ✓

---

Happy character creating! 🎨
