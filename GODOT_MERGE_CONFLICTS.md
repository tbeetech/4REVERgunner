# Resolving Godot Merge Conflicts

Godot scene files (`.tscn`) and resource files (`.tres`) are text-based, which is great for version control. However, they can have merge conflicts when multiple people edit the same scene.

**CRITICAL RULE**: 🚨 **Never open a conflicted scene in Godot until all merge conflict markers are removed!** 🚨

Opening a conflicted scene in Godot will cause the editor to corrupt the file or fail to load it, making the conflict harder to resolve.

## Understanding Godot Scene Files

Godot scene files are text-based with a specific format:

```
[gd_scene load_steps=2 format=3 uid="uid://..."]

[node name="Root" type="Node3D"]

[node name="Child" type="MeshInstance3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0)
```

When Git detects a conflict, it adds markers:

```
<<<<<<< HEAD
[node name="Player" type="CharacterBody3D"]
position = Vector3(0, 0, 0)
=======
[node name="Player" type="CharacterBody3D"]
position = Vector3(5, 0, 0)
>>>>>>> feature/new-position
```

## Step-by-Step Conflict Resolution

### Step 1: Identify Conflicted Files

```bash
# Check for conflicts after a merge or pull
git status

# Look for files marked as "both modified"
# Example output:
# both modified:   scenes/main.tscn
```

### Step 2: Examine the Conflict

**DO NOT open the scene in Godot yet!**

Open the conflicted file in a text editor:

```bash
# Use your preferred text editor
code scenes/main.tscn      # VS Code
nano scenes/main.tscn      # Terminal editor
gedit scenes/main.tscn     # Linux GUI editor
```

### Step 3: Understand the Conflict

Look for conflict markers:

```
<<<<<<< HEAD             # Your current branch
... your changes ...
=======                  # Divider
... their changes ...
>>>>>>> feature-branch   # The branch you're merging
```

**Common conflict scenarios**:
1. **Position/Transform conflicts**: Two people moved the same node
2. **Property conflicts**: Different values for the same property
3. **Node additions**: Both branches added nodes in the same location
4. **UID conflicts**: Godot assigns unique IDs that may conflict

### Step 4: Resolve the Conflict

**Option A: Accept One Side Completely**

If one side is clearly correct:

```bash
# Accept your changes (HEAD)
git checkout --ours scenes/main.tscn

# Accept their changes (incoming branch)
git checkout --theirs scenes/main.tscn
```

**Option B: Manually Merge Changes**

If you need to combine both changes:

1. Open the file in a text editor
2. Remove conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Keep the desired changes from both sides
4. Ensure the file remains valid Godot format

**Example - Resolving a position conflict**:

Before (conflicted):
```
<<<<<<< HEAD
[node name="Player" type="CharacterBody3D"]
position = Vector3(0, 0, 0)
=======
[node name="Player" type="CharacterBody3D"]
position = Vector3(5, 0, 0)
>>>>>>> feature/new-position
```

After (resolved to new position):
```
[node name="Player" type="CharacterBody3D"]
position = Vector3(5, 0, 0)
```

**Example - Merging added nodes**:

Before (conflicted):
```
[node name="Game" type="Node3D" parent="."]
<<<<<<< HEAD

[node name="Player" type="CharacterBody3D" parent="Game"]
=======

[node name="Enemy" type="Node3D" parent="Game"]
>>>>>>> feature/add-enemy
```

After (keep both):
```
[node name="Game" type="Node3D" parent="."]

[node name="Player" type="CharacterBody3D" parent="Game"]

[node name="Enemy" type="Node3D" parent="Game"]
```

### Step 5: Validate the File

**Important**: Before opening in Godot, manually check:

1. **No conflict markers remain**: Search for `<<<<<<<`, `=======`, `>>>>>>>`
2. **Proper indentation**: Godot uses consistent indentation
3. **Matching brackets**: All `[` have corresponding `]`
4. **Valid syntax**: `key = value` format for properties

```bash
# Search for remaining conflict markers
grep -n "<<<<<<" scenes/main.tscn
grep -n ">>>>>>>" scenes/main.tscn

# If no output, you're clear to proceed
```

### Step 6: Test in Godot

Now it's safe to open the file in Godot:

1. Open Godot
2. Let it reimport if necessary
3. Open the scene (`scenes/main.tscn`)
4. Check for errors in the Output panel
5. Verify the scene looks correct

If Godot shows errors:
- Close Godot
- Review the `.tscn` file again in a text editor
- Look for malformed nodes or properties
- Fix syntax errors and retry

### Step 7: Mark as Resolved and Commit

```bash
# Stage the resolved file
git add scenes/main.tscn

# If merging, complete the merge
git commit -m "merge: resolve conflicts in main scene"

# If rebasing, continue the rebase
git rebase --continue
```

## Advanced: Using Merge Tools

For complex conflicts, use a merge tool:

```bash
# Configure a merge tool (e.g., VS Code)
git config merge.tool vscode
git config mergetool.vscode.cmd 'code --wait --merge $REMOTE $LOCAL $BASE $MERGED'

# Use the merge tool
git mergetool scenes/main.tscn
```

Popular merge tools:
- **VS Code** (built-in merge editor)
- **Meld** (Linux GUI tool)
- **KDiff3** (cross-platform)
- **P4Merge** (Perforce's free tool)

## Prevention: Avoiding Conflicts

### Best Practices

1. **Communicate**: Let team members know which scenes you're editing
2. **Pull frequently**: Run `git pull` before starting work
3. **Small commits**: Commit small, focused changes often
4. **Modular scenes**: Split large scenes into smaller subscenes
5. **Scene instances**: Use instanced scenes instead of editing one big scene

### Scene Organization Strategy

Instead of everyone editing `main.tscn`, use scene composition:

```
scenes/
├── main.tscn              # Main scene (rarely edited)
│   ├── Player (instance of player.tscn)
│   ├── UI (instance of ui.tscn)
│   └── Environment (instance of environment.tscn)
├── player.tscn            # One person works on player
├── ui.tscn                # Another person works on UI
└── environment.tscn       # Another person works on environment
```

This way, conflicts are rare because people work in separate files.

## Troubleshooting

### "Invalid scene format" in Godot

**Cause**: The `.tscn` file has syntax errors from conflict resolution.

**Solution**:
1. Close Godot
2. Open the `.tscn` in a text editor
3. Look for:
   - Unmatched brackets `[` or `]`
   - Missing `=` in property assignments
   - Duplicate node names
4. Fix errors and reopen in Godot

### "Could not load resource" errors

**Cause**: UIDs or resource paths are broken.

**Solution**:
1. Check the `[ext_resource]` and `[sub_resource]` sections at the top
2. Ensure IDs are unique and sequential
3. Verify paths to external resources (scripts, scenes) exist

### Conflict markers still present

**Cause**: You opened the scene in Godot before removing markers.

**Solution**:
1. **Revert to before the merge**: `git merge --abort` or `git rebase --abort`
2. Start over, resolving conflicts properly in a text editor first

### "Cannot open file in Godot" after resolution

**Cause**: File is corrupted or has invalid syntax.

**Solution**:
```bash
# Compare with the original
git show HEAD:scenes/main.tscn > /tmp/original.tscn

# Check differences
diff scenes/main.tscn /tmp/original.tscn

# If too broken, accept one side and redo changes manually
git checkout --ours scenes/main.tscn
# Then reapply the other changes manually in Godot
```

## UID Conflicts

Godot 4 uses UIDs for resource tracking. Conflicts can occur:

```
<<<<<<< HEAD
[gd_scene load_steps=2 format=3 uid="uid://abc123"]
=======
[gd_scene load_steps=2 format=3 uid="uid://xyz789"]
>>>>>>> feature-branch
```

**Resolution**: Keep one UID (usually `HEAD`). Godot will regenerate if necessary.

## Summary Checklist

When resolving a Godot scene conflict:

- [ ] Identify conflicted `.tscn` or `.tres` files with `git status`
- [ ] **DO NOT** open the file in Godot yet
- [ ] Open the file in a text editor
- [ ] Locate and understand conflict markers
- [ ] Choose a resolution strategy (accept one side, or manually merge)
- [ ] Remove all conflict markers
- [ ] Validate the file syntax (no markers, proper format)
- [ ] Now open the scene in Godot and test
- [ ] Fix any errors reported by Godot
- [ ] Stage and commit the resolved file

## Additional Resources

- [Git Documentation: Merge Conflicts](https://git-scm.com/docs/git-merge#_how_conflicts_are_presented)
- [Godot Docs: Version Control](https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html)
- [Pro Git Book: Basic Merge Conflicts](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)

---

**Remember**: Always resolve conflicts in a text editor first, then validate in Godot. Never open a conflicted scene in Godot!
