# Contributing to 4REVERgunner

Thank you for your interest in contributing! This guide will help you get started, especially if you're new to game development or Git workflows.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/4REVERgunner.git
   cd 4REVERgunner
   ```
3. **Set up Git LFS** (important for handling large files):
   ```bash
   git lfs install
   git lfs pull
   ```

## Branching Workflow

We use a simple branching strategy suitable for beginners:

### Branch Naming Convention

- `feature/` - For new features (e.g., `feature/double-jump`)
- `fix/` - For bug fixes (e.g., `fix/player-collision`)
- `docs/` - For documentation updates (e.g., `docs/update-readme`)
- `asset/` - For new assets (e.g., `asset/player-model`)

### Creating a Branch

```bash
# Make sure you're on the latest master
git checkout master
git pull origin master

# Create and switch to a new branch
git checkout -b feature/your-feature-name
```

### Making Changes

```bash
# Make your changes in Godot or your text editor

# Check what files changed
git status

# Stage your changes
git add .

# Commit with a descriptive message
git commit -m "Add double-jump ability to player"

# Push to your fork
git push origin feature/your-feature-name
```

## Git LFS for Assets

Large binary files (models, textures, audio) should be tracked with Git LFS:

### Setting Up LFS for New File Types

```bash
# Track .glb files (3D models)
git lfs track "*.glb"

# Track .png files (textures)
git lfs track "*.png"

# This creates/updates .gitattributes
git add .gitattributes
git commit -m "Configure LFS tracking for .glb and .png"
```

### Adding LFS Files

```bash
# Add your file normally
git add models/character.glb

# Commit (LFS handles it automatically)
git commit -m "Add character model"

# Push (may take longer for large files)
git push
```

## MakeHuman + Blender Pipeline

Follow these steps to create and import custom characters:

### 1. Create Character in MakeHuman
- Open MakeHuman
- Customize your character (body, face, etc.)
- Go to **Files → Export**
- Format: **Collada (dae)** or **FBX**
- Export with skeleton/rig if you plan to animate

### 2. Edit in Blender
- Import the MakeHuman file into Blender
- Clean up the mesh if needed
- Apply materials and textures
- Export as **glTF 2.0** (.glb or .gltf):
  - File → Export → glTF 2.0
  - Format: **glTF Binary (.glb)** recommended
  - Include: Selected Objects (or entire scene)
  - Transform: **+Y Up** (Godot uses Y-up)

### 3. Import to Godot
- Drag the `.glb` file into your Godot project's file system
- Godot will automatically import it
- You can now use it in scenes

For detailed steps, see `ASSET_PIPELINE_MAKEHUMAN.md`.

## Pull Request Checklist

Before submitting a pull request, make sure:

- [ ] Code follows existing style (indentation, naming conventions)
- [ ] All new GDScript code uses Godot 4 syntax
- [ ] Scenes are saved in text format (.tscn), not binary (.scn)
- [ ] No unnecessary files committed (check `.gitignore`)
- [ ] Large files tracked with Git LFS
- [ ] Project runs without errors in Godot 4
- [ ] Tested your changes (play the game!)
- [ ] Updated documentation if adding features
- [ ] Descriptive commit messages
- [ ] PR description explains what and why

## Pull Request Process

1. **Push your branch** to your fork on GitHub
2. **Open a Pull Request** from your branch to `master` in the main repository
3. **Fill in the PR template** with:
   - What changed
   - Why you made the change
   - How to test it
4. **Wait for review** - maintainers will review and may request changes
5. **Make requested changes** by pushing new commits to your branch
6. **Merge** - Once approved, a maintainer will merge your PR

## Merge Conflicts

If you get a merge conflict (especially in `.tscn` files), see `GODOT_MERGE_CONFLICTS.md` for step-by-step resolution instructions.

## Code Style Guidelines

### GDScript
- Use **snake_case** for variables and functions: `player_speed`, `shoot_projectile()`
- Use **PascalCase** for class names: `PlayerController`, `EnemySpawner`
- Use **UPPER_CASE** for constants: `MAX_SPEED`, `SPAWN_RATE`
- Indent with **tabs** (Godot default)
- Add comments for complex logic

### Scene Organization
- Keep scene files in `scenes/` folder
- Keep scripts in `scripts/` folder
- Use descriptive names: `player_placeholder.tscn`, not `p1.tscn`

## Getting Help

- **Issues**: Use GitHub Issues to report bugs or request features
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Godot Docs**: [docs.godotengine.org](https://docs.godotengine.org/)

## Code of Conduct

- Be respectful and constructive
- Welcome beginners and help them learn
- Focus on the code, not the person
- Give credit where it's due

Happy coding! 🎮
