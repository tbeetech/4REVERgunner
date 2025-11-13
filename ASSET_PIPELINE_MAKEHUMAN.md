# Asset Pipeline: MakeHuman → Blender → Godot

This guide provides a complete, step-by-step workflow for creating custom 3D character assets using **MakeHuman** and **Blender**, then exporting them to **Godot 4** in a game-ready format.

## Overview

The asset pipeline has three stages:
1. **MakeHuman**: Create the base character model
2. **Blender**: Refine, rig, animate, and export
3. **Godot**: Import and integrate into the game

**Timeline**: 30-90 minutes per character (faster after first time)

---

## Stage 1: Character Creation in MakeHuman

### Prerequisites
- **MakeHuman 1.2+** installed ([download](http://www.makehumancommunity.org/content/downloads.html))
- Basic understanding of human anatomy helps but isn't required

### Step 1: Launch MakeHuman

1. Open MakeHuman
2. You'll see a default character model in the center

### Step 2: Customize the Character

#### Body Proportions
1. **Navigate tabs on the left**: Gender, Age, Muscle, Weight, Height, Proportions
2. **Use sliders** to adjust:
   - **Gender**: Male ↔ Female (can be androgynous)
   - **Age**: Child → Elder
   - **Muscle**: Scrawny ↔ Muscular
   - **Weight**: Underweight ↔ Overweight
   - **Height**: Short ↔ Tall
   - **Proportions**: Adjust limbs, torso, head size

**Tip**: Click "Randomize" at the bottom for a random starting point.

#### Facial Features (Optional for Game Characters)
1. Go to **Modelling → Face** tab
2. Adjust nose, eyes, mouth, ears, chin
3. Use subtle changes (extreme settings can look unrealistic)

#### Skin and Materials
1. Go to **Geometries → Topologies** (keep default "Base Mesh")
2. Go to **Materials → Skin** to choose skin tone
3. Add texture details (optional, we'll use Blender for final materials)

### Step 3: Add Basic Clothing (Optional)

1. Go to **Geometries → Clothes** tab
2. Browse available clothing items
3. Click on items to equip (e.g., shirt, pants, shoes)
4. Adjust fitting if needed (usually automatic)

**Note**: For game characters, simple or no clothing works best (easier to texture later).

### Step 4: Pose (Optional for Static Models)

1. Go to **Pose/Animate** tab
2. Choose a default pose (T-pose or A-pose recommended for rigging)
3. **Important**: For game characters, export in **T-pose** or **A-pose**

### Step 5: Export from MakeHuman

**Export Format**: We'll use **Collada (.dae)** or **FBX** for Blender compatibility.

1. Go to **Files → Export** tab
2. Configure export settings:
   - **Format**: Choose **Collada (dae)** (best compatibility) or **FBX**
   - **Scale units**: Set to **Meter** (matches Godot/Blender)
   - **Options**:
     - ✅ **Rig**: Check if you need bones (usually yes)
     - ✅ **Binary**: Uncheck (for DAE, use text format)
     - ✅ **Z up**: Check (Blender/Godot use Z-up axis)
3. Click **Export**
4. Save as `character_name.dae` in a working folder

**Example settings**:
```
Format: Collada (dae)
Scale: Meter
Rig: ✅ Enabled
Z up: ✅ Enabled
```

---

## Stage 2: Refinement and Export in Blender

### Prerequisites
- **Blender 3.x+** installed ([download](https://www.blender.org/download/))
- Basic Blender navigation (optional but helpful)

### Step 1: Import Character into Blender

1. **Open Blender** (new file, default scene)
2. **Delete the default cube**: Select it (click), press `X`, confirm delete
3. **Import the character**:
   - Go to **File → Import → Collada (.dae)** (or FBX if you exported FBX)
   - Navigate to your exported MakeHuman file
   - Click **Import**
4. The character should appear (might be small or large depending on scale)

### Step 2: Check Scale and Orientation

1. **Check scale**: The character should be roughly 1.7-2.0 Blender units tall
2. If too small/large:
   - Select the character (click on it)
   - Press `S` (scale), type `10` or `0.1` to adjust, press Enter
   - Press `Ctrl+A` → **Apply → All Transforms** to apply scale

3. **Check orientation**:
   - Character should face **-Y axis** (forward in Godot)
   - If facing wrong direction, rotate: Press `R` → `Z` → `90` (or `-90`)

### Step 3: Clean Up Geometry (Optional but Recommended)

1. **Switch to Edit Mode**: Press `Tab` or select "Edit Mode" in top-left dropdown
2. **Remove hidden geometry**: 
   - Go to **Mesh → Clean Up → Delete Loose** (removes floating vertices)
3. **Merge close vertices**:
   - Select all (`A`)
   - Press `M` → **By Distance** (merges overlapping verts)
4. **Switch back to Object Mode**: Press `Tab`

### Step 4: Materials and Textures (Optional)

MakeHuman exports with basic materials. For game-ready assets:

1. **Switch to Shading workspace** (top tabs)
2. You'll see materials in the bottom panel (Shader Editor)
3. **Simplify materials**:
   - Delete complex nodes
   - Use a single **Principled BSDF** node
   - Add textures if you have custom ones
4. **Or use Godot materials**: Export without textures, apply in Godot

**Recommendation**: Keep materials simple in Blender, refine in Godot.

### Step 5: Check Armature (Rig)

If you exported with a rig:

1. Look for an **Armature** object in the outliner (top-right panel)
2. Select the armature, switch to **Pose Mode**
3. Test moving bones to verify the rig works
4. **Switch back to Object Mode** before exporting

### Step 6: Export to glTF (.glb)

**glTF 2.0** is Godot's preferred format. We'll use the **binary .glb** format.

1. **Select the character and armature** (hold Shift to multi-select)
2. Go to **File → Export → glTF 2.0 (.glb/.gltf)**
3. Configure export settings:

**Critical Settings**:
```
Format: glTF Binary (.glb)
Include:
  ✅ Selected Objects (if you selected only what you need)
  ✅ Custom Properties
  ✅ Cameras (uncheck if not needed)
  ✅ Punctual Lights (uncheck if not needed)

Transform:
  ✅ +Y Up (Godot's coordinate system)

Geometry:
  ✅ Apply Modifiers
  ✅ UVs
  ✅ Normals
  ✅ Tangents
  ☑️ Vertex Colors (if you painted any)
  Compression: None (or enable for smaller files)

Animation:
  ✅ Animation (if you added any)
  ☑️ Shape Keys (blend shapes, if used)
  ✅ Skinning (for rigged characters)
  ☑️ Bake Skins (optional, for optimized export)

Shading:
  Materials: Export
  Images: Automatic (or embedded)
```

4. **File name**: Use descriptive names like `hero_character.glb`
5. Click **Export glTF 2.0**

### Troubleshooting Blender Export

| Issue | Solution |
|-------|----------|
| **Character too small in Godot** | Apply scale in Blender before export (`Ctrl+A` → Apply Scale) |
| **Missing textures** | Check "Images: Automatic" or "Embedded" in export |
| **Character facing wrong way** | Rotate in Blender before export (face -Y axis) |
| **Rig not working** | Ensure "Skinning" is enabled in export settings |
| **Huge file size** | Enable compression in export or reduce texture resolution |

---

## Stage 3: Import into Godot 4

### Step 1: Prepare Asset Folder

1. In Godot's **FileSystem** panel, create a folder structure:
   ```
   res://assets/models/characters/
   ```
2. Place your exported `.glb` file there (e.g., `hero_character.glb`)

### Step 2: Import the Model

1. **Godot auto-imports** when you focus the editor window
2. Wait for the import to complete (check progress at bottom of editor)
3. The `.glb` file will appear in the FileSystem panel

### Step 3: Configure Import Settings (Optional)

1. Click on the `.glb` file
2. Go to the **Import** tab (top, next to Scene)
3. Adjust settings if needed:
   - **Root Type**: Node3D (default)
   - **Root Name**: Auto-generated
   - **Animation** settings (if animated)
4. Click **Reimport** if you change settings

### Step 4: Instance the Character in a Scene

**Option A: Drag and Drop**
1. Open your scene (e.g., `res://scenes/main.tscn`)
2. Drag the `.glb` file from FileSystem into the Scene tree
3. It instances as a child node

**Option B: Instance Child Scene**
1. Right-click on a parent node in the Scene tree
2. Select **Instance Child Scene**
3. Choose your `.glb` file
4. Click **Open**

### Step 5: Adjust Transform

The character might need position/rotation/scale adjustments:

1. Select the instanced model in the Scene tree
2. Use the **Inspector** panel (right side) to adjust:
   - **Position**: Move to desired location
   - **Rotation**: Ensure correct facing direction
   - **Scale**: Usually `(1, 1, 1)`, adjust if needed

### Step 6: Test in Game

1. Press **F5** or click Play to run the game
2. Verify the character appears correctly
3. Check textures, scale, and positioning

---

## Common Issues and Solutions

### Issue: Character is Invisible in Godot

**Causes and Solutions**:
1. **Too far from camera**: Move character to `(0, 0, 0)` or adjust camera
2. **Inside another object**: Check position and move if needed
3. **Material issues**: Inspect material, ensure it's not fully transparent
4. **Culling**: Check "Visible" is enabled in Inspector

### Issue: Textures Missing or Wrong Colors

**Solutions**:
1. **Check image paths**: Open the `.glb` in the FileSystem, expand it, check materials
2. **Re-export from Blender** with "Images: Embedded" or "Automatic"
3. **Manually assign textures** in Godot:
   - Select the material
   - In Inspector, add textures to Albedo, Normal, etc.

### Issue: Character Scale is Wrong

**Solutions**:
1. **In Blender**: Apply scale (`Ctrl+A` → Apply Scale) before export
2. **In Godot**: Adjust scale in Inspector (try `0.1` or `10` multipliers)
3. **Check units**: Ensure MakeHuman and Blender use Meters

### Issue: Rig/Bones Not Working

**Solutions**:
1. **Blender**: Ensure "Skinning" is checked in glTF export
2. **Godot**: Check if AnimationPlayer node is present (should auto-create)
3. **Weights**: Character needs proper weight painting (usually automatic from MakeHuman)

### Issue: Character Facing Wrong Direction

**Solutions**:
1. **Blender**: Rotate character to face **-Y axis** before export
2. **Godot**: Rotate the instanced model 180° around Y-axis (`Rotation Y = 180`)

### Issue: Animations Not Playing

**Solutions**:
1. **Check AnimationPlayer node**: Should be auto-created with the imported model
2. **Blender**: Ensure animations are exported ("Animation" checked in glTF export)
3. **Test animation**: Select AnimationPlayer, choose animation in Inspector, click Play

---

## Optimization Tips

### Reducing File Size
- **Lower texture resolution**: 1024x1024 or 512x512 for most game characters
- **Use compression**: Enable in Blender glTF export or Godot import settings
- **Reduce polygon count**: Use Blender's Decimate modifier (Edit Mode → Modifiers)

### Performance in Godot
- **LOD (Level of Detail)**: Create multiple versions (high/medium/low poly)
- **Bake textures**: Combine multiple textures into one atlas
- **Use visibility ranges**: Hide distant characters to save performance

### Reusable Characters
- **Create variants**: Export base character, create variations in Godot (different materials, colors)
- **Modular design**: Separate body parts (head, torso, legs) for mix-and-match

---

## Quick Reference Checklist

### MakeHuman Export
- [ ] Character created and customized
- [ ] Posed in T-pose or A-pose
- [ ] Export format: Collada (.dae) or FBX
- [ ] Scale: Meter
- [ ] Rig: Enabled (if needed)
- [ ] Z up: Enabled

### Blender Process
- [ ] Import character (.dae or .fbx)
- [ ] Check scale (1.7-2.0 units tall)
- [ ] Character faces -Y axis
- [ ] Apply transforms (Ctrl+A → All Transforms)
- [ ] Export as glTF Binary (.glb)
- [ ] +Y Up enabled in export
- [ ] Skinning enabled (for rigged characters)

### Godot Import
- [ ] Place .glb in `res://assets/models/`
- [ ] Wait for auto-import
- [ ] Instance in scene
- [ ] Adjust position/rotation/scale
- [ ] Test in game (F5)
- [ ] Verify textures and materials

---

## Additional Resources

### Tutorials
- [MakeHuman Official Documentation](http://www.makehumancommunity.org/wiki/Documentation:Index)
- [Blender glTF Export Guide](https://docs.blender.org/manual/en/latest/addons/import_export/scene_gltf2.html)
- [Godot Importing 3D Scenes](https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/index.html)

### Community Assets
- [MakeHuman Assets](http://www.makehumancommunity.org/content/user_contributed_assets.html) - Community clothing, poses
- [Mixamo](https://www.mixamo.com/) - Free character animations (requires Adobe account)

### Troubleshooting
- [Godot Q&A](https://godotengine.org/qa/) - Community support
- [Blender Artists Forum](https://blenderartists.org/) - Blender help
- [MakeHuman Forums](http://www.makehumancommunity.org/forum/) - Character creation help

---

**Success Path**: MakeHuman (30 min) → Blender (20 min) → Godot (5 min) → In-game character! 🎉

Practice makes perfect. Your first character might take 2 hours, but subsequent ones will be much faster (30-60 minutes).
