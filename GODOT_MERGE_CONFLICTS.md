# Resolving Merge Conflicts in Godot Files

Merge conflicts in Godot scene (.tscn) and resource (.tres) files can be tricky because these are structured text files that Godot generates. Here's how to resolve them safely.

## ⚠️ Important Rules

1. **DO NOT** open conflicted scenes in Godot until conflict markers are removed
2. **DO NOT** try to fix conflicts by re-saving the scene in Godot (you may lose changes)
3. **ALWAYS** resolve conflicts in a text editor first
4. **VERIFY** the file structure is valid before opening in Godot

## Step-by-Step Resolution

### Step 1: Identify the Conflict

When you pull or merge, Git will tell you which files have conflicts:

```bash
git status
```

Look for files marked as "both modified":
```
Unmerged paths:
  both modified:   scenes/main.tscn
```

### Step 2: Open in Text Editor

Open the conflicted file in a text editor (VS Code, Sublime, Notepad++, etc.):

```bash
# Example
code scenes/main.tscn
```

You'll see conflict markers like this:

```
[node name="Player" type="CharacterBody3D" parent="."]
<<<<<<< HEAD
position = Vector3(0, 1, 0)
speed = 5.0
=======
position = Vector3(0, 2, 0)
speed = 6.0
>>>>>>> feature/faster-player
```

### Step 3: Understand the Conflict

- `<<<<<<< HEAD` - Your current branch's version
- `=======` - Separator
- `>>>>>>> branch-name` - The incoming branch's version

### Step 4: Decide Which Version to Keep

#### Option A: Keep YOUR changes (HEAD)
Delete the conflict markers and the other version:
```
[node name="Player" type="CharacterBody3D" parent="."]
position = Vector3(0, 1, 0)
speed = 5.0
```

#### Option B: Keep THEIR changes (incoming)
Delete the conflict markers and your version:
```
[node name="Player" type="CharacterBody3D" parent="."]
position = Vector3(0, 2, 0)
speed = 6.0
```

#### Option C: Merge both changes manually
Combine the changes logically:
```
[node name="Player" type="CharacterBody3D" parent="."]
position = Vector3(0, 2, 0)
speed = 6.0
```

### Step 5: Remove ALL Conflict Markers

Search the entire file for:
- `<<<<<<<`
- `=======`
- `>>>>>>>`

Remove all of them. The file should be clean text with no markers.

### Step 6: Verify File Structure

Before opening in Godot, check:
- All `[` brackets have matching `]`
- All sections are properly closed
- No stray conflict markers remain
- File ends with a newline

### Step 7: Mark as Resolved

```bash
# Stage the resolved file
git add scenes/main.tscn

# Check status
git status
```

### Step 8: Complete the Merge

```bash
# Commit the merge
git commit -m "Resolve merge conflict in main.tscn"
```

### Step 9: Test in Godot

Now you can safely open the scene in Godot:
1. Open Godot
2. Open the resolved scene
3. Check that everything loads correctly
4. Test the game to ensure functionality

## Common Conflict Scenarios

### ExtResource ID Conflicts

If two branches add different resources with the same ID:

```
<<<<<<< HEAD
[ext_resource type="Script" path="res://scripts/player.gd" id="1_abc"]
=======
[ext_resource type="PackedScene" path="res://scenes/bullet.tscn" id="1_xyz"]
>>>>>>> feature/shooting
```

**Solution**: Renumber the IDs to be unique:
```
[ext_resource type="Script" path="res://scripts/player.gd" id="1_abc"]
[ext_resource type="PackedScene" path="res://scenes/bullet.tscn" id="2_xyz"]
```

Then update any references to use the new IDs.

### Node Property Conflicts

Properties modified in both branches:

```
<<<<<<< HEAD
speed = 5.0
jump_height = 3.0
=======
speed = 6.0
dash_speed = 10.0
>>>>>>> feature/dash
```

**Solution**: Keep all properties that don't conflict:
```
speed = 6.0
jump_height = 3.0
dash_speed = 10.0
```

### Node Addition Conflicts

Both branches add nodes at the same location - usually Git can handle this, but verify the node hierarchy makes sense after resolution.

## Prevention Tips

### 1. Pull Before You Work
```bash
git pull origin master
```

### 2. Make Small, Focused Changes
- Smaller changes = fewer conflicts
- Work on separate scenes/scripts when possible

### 3. Communicate with Team
- Coordinate who's working on which scenes
- Use separate branches for different features

### 4. Use Godot's Node Names Carefully
- Avoid renaming nodes that others might reference
- Use unique names to prevent ID collisions

### 5. Commit Often
- Frequent commits make it easier to track changes
- Easier to resolve smaller conflicts

## When to Ask for Help

If you encounter:
- Multiple complex conflicts in one file
- Conflicts in binary files (.scn, .res saved as binary)
- Conflicts that break the file structure after resolution
- Uncertainty about which changes to keep

**Ask a maintainer or more experienced developer for help!**

## Tools to Help

### Visual Merge Tools
- **VS Code** - Built-in merge conflict resolver
- **KDiff3** - Free merge tool
- **Meld** - Linux merge tool
- **P4Merge** - Free from Perforce

Configure Git to use a merge tool:
```bash
git config --global merge.tool vscode
git mergetool
```

## Emergency: Start Over

If resolution seems impossible:

```bash
# Abort the merge
git merge --abort

# OR abort the rebase
git rebase --abort

# Start fresh
git fetch origin
git reset --hard origin/master
```

**Warning**: This discards your local changes. Make sure you have a backup!

## Final Checklist

Before committing a conflict resolution:
- [ ] All conflict markers removed
- [ ] File opens correctly in Godot
- [ ] Scene/resource works as expected
- [ ] No error messages in Godot console
- [ ] Changes from both branches preserved (if intended)
- [ ] Tested the game functionality

---

Remember: When in doubt, ask for help! It's better to get assistance than to break the project.
