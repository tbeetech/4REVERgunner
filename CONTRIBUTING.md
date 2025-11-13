# Contributing to 4REVERgunner

Thank you for your interest in contributing! This document provides guidelines for team collaboration, asset creation, and code contributions.

## Table of Contents
- [Getting Started](#getting-started)
- [Branching Strategy](#branching-strategy)
- [Commit Guidelines](#commit-guidelines)
- [Working with Git LFS](#working-with-git-lfs)
- [Asset Pipeline: MakeHuman + Blender](#asset-pipeline-makehuman--blender)
- [Code Style Guidelines](#code-style-guidelines)
- [Testing Your Changes](#testing-your-changes)
- [Pull Request Process](#pull-request-process)

## Getting Started

1. **Fork the repository** (for external contributors) or **clone directly** (for team members)
2. **Set up Git LFS**: Run `git lfs install` in the repository
3. **Open the project in Godot 4** and verify it runs
4. **Read the documentation**: Familiarize yourself with README.md and ASSET_PIPELINE_MAKEHUMAN.md

## Branching Strategy

We follow a simple **feature branch workflow**:

### Branch Naming Convention
- `feature/short-description` - For new features (e.g., `feature/enemy-ai`)
- `bugfix/short-description` - For bug fixes (e.g., `bugfix/player-collision`)
- `asset/short-description` - For new assets (e.g., `asset/hero-character`)
- `docs/short-description` - For documentation updates

### Creating a Branch

```bash
# Make sure you're on the latest master
git checkout master
git pull origin master

# Create and switch to your feature branch
git checkout -b feature/your-feature-name
```

### Example Workflow

```bash
# Create a branch for your work
git checkout -b feature/add-shooting-mechanic

# Make your changes in Godot and your text editor
# Save your work frequently

# Stage your changes
git add .

# Commit with a descriptive message (see Commit Guidelines below)
git commit -m "feat: add shooting mechanic with cooldown"

# Push to GitHub
git push origin feature/add-shooting-mechanic

# Open a Pull Request on GitHub (see Pull Request Process below)
```

## Commit Guidelines

We follow **Conventional Commits** for clear commit history:

### Format
```
<type>(<scope>): <subject>

<optional body>
```

### Types
- `feat:` - New feature (e.g., `feat: add enemy spawning system`)
- `fix:` - Bug fix (e.g., `fix: correct player movement speed`)
- `docs:` - Documentation only (e.g., `docs: update asset pipeline guide`)
- `style:` - Code style/formatting (e.g., `style: format player script`)
- `refactor:` - Code restructuring without changing behavior
- `test:` - Adding or fixing tests
- `chore:` - Maintenance tasks (e.g., `chore: update .gitignore`)
- `asset:` - Adding or updating assets (e.g., `asset: add hero character model`)

### Examples
```bash
git commit -m "feat: add player health system"
git commit -m "fix: resolve player clipping through walls"
git commit -m "asset: add enemy spaceship model from MakeHuman pipeline"
git commit -m "docs: add troubleshooting section to README"
```

## Working with Git LFS

**Git LFS (Large File Storage)** is essential for handling binary assets like `.glb`, `.png`, and `.wav` files.

### Initial Setup (One-Time)

```bash
# Install Git LFS (if not already installed)
# macOS: brew install git-lfs
# Ubuntu: sudo apt-get install git-lfs
# Windows: download from git-lfs.github.com

# Initialize LFS in your local repository
git lfs install
```

### Adding Large Files

The `.gitattributes` file already configures LFS tracking for common asset types. Simply add and commit as usual:

```bash
# Add a new character model
git add assets/models/hero.glb

# Commit (LFS handles it automatically)
git commit -m "asset: add hero character model"

# Push (LFS uploads the binary to LFS storage)
git push origin feature/hero-character
```

### Pulling LFS Files

When cloning or pulling:

```bash
# Clone with LFS files
git clone https://github.com/tbeetech/4REVERgunner.git
cd 4REVERgunner
git lfs pull

# Or if already cloned, pull LFS files
git lfs pull
```

### Checking LFS Status

```bash
# See which files are tracked by LFS
git lfs ls-files

# See LFS storage usage
git lfs status
```

## Asset Pipeline: MakeHuman + Blender

For detailed instructions, see **[ASSET_PIPELINE_MAKEHUMAN.md](ASSET_PIPELINE_MAKEHUMAN.md)**.

### Quick Summary

1. **Create in MakeHuman**:
   - Design your character
   - Export as MakeHuman Exchange (.mhx2) or Collada (.dae)

2. **Refine in Blender**:
   - Import the character
   - Add animations, materials, or modifications
   - Export as glTF 2.0 Binary (.glb)

3. **Import to Godot**:
   - Place .glb in `assets/models/`
   - Godot auto-imports on focus
   - Instance the model in your scene

4. **Commit with LFS**:
   ```bash
   git add assets/models/character.glb
   git commit -m "asset: add character model via MakeHuman pipeline"
   git push
   ```

### Asset Organization

```
assets/
├── models/       # .glb files from Blender
│   ├── characters/
│   │   ├── hero.glb
│   │   └── enemy.glb
│   └── props/
├── textures/     # .png, .jpg files
├── audio/        # .wav, .ogg files
└── materials/    # .tres material files
```

## Code Style Guidelines

### GDScript Best Practices

1. **Use snake_case for variables and functions**:
   ```gdscript
   var player_speed = 10.0
   func move_player():
   ```

2. **Use PascalCase for class names**:
   ```gdscript
   class_name PlayerController
   ```

3. **Add type hints**:
   ```gdscript
   var health: int = 100
   func take_damage(amount: int) -> void:
   ```

4. **Comment complex logic**:
   ```gdscript
   # Calculate trajectory accounting for gravity
   var trajectory = velocity * delta + 0.5 * gravity * delta * delta
   ```

5. **Use `@export` for inspector-editable variables**:
   ```gdscript
   @export var speed: float = 5.0
   @export var max_health: int = 100
   ```

### Scene Structure

- Keep scenes modular and reusable
- Use meaningful node names (e.g., "Player" not "Node3D")
- Organize related nodes under parent containers
- Attach scripts to the root node of a scene

## Testing Your Changes

Before committing:

1. **Run the game**: Press F5 in Godot and test your changes
2. **Check the console**: Look for errors or warnings
3. **Test edge cases**: Try unexpected inputs or scenarios
4. **Verify performance**: Ensure no major frame drops

### Manual Testing Checklist
- [ ] Game starts without errors
- [ ] Player movement works as expected
- [ ] New features function correctly
- [ ] No visual glitches or artifacts
- [ ] Console has no new errors or warnings

## Pull Request Process

### Before Opening a PR

1. **Update your branch**:
   ```bash
   git checkout master
   git pull origin master
   git checkout feature/your-feature
   git merge master
   # Resolve any conflicts (see GODOT_MERGE_CONFLICTS.md)
   ```

2. **Test your changes** (see Testing Your Changes above)

3. **Review your commits**: Ensure commit messages follow guidelines

### Opening a PR

1. Push your branch: `git push origin feature/your-feature`
2. Go to GitHub and click **New Pull Request**
3. Select `master` as the base branch
4. Select your feature branch as the compare branch
5. Fill out the PR template:

**PR Title**: Use the same format as commit messages
```
feat: add shooting mechanic with cooldown
```

**PR Description**: Include:
- **What**: What changes were made?
- **Why**: Why were these changes necessary?
- **How to test**: Steps to verify the changes
- **Screenshots/Videos**: If applicable (for visual changes)

### Example PR Description
```markdown
## What
Added a shooting mechanic for the player with a 0.5s cooldown between shots.

## Why
To implement the core gameplay loop of the endless shooter.

## How to Test
1. Open res://scenes/main.tscn
2. Run the game (F5)
3. Press Space to shoot
4. Verify projectiles spawn and move forward
5. Verify cooldown prevents rapid-fire spam

## Screenshots
(Attach screenshot or GIF of shooting in action)
```

### PR Review Process

- At least one team member should review the PR
- Address any feedback or requested changes
- Once approved, the PR can be merged into `master`

## Merge Conflict Resolution

**IMPORTANT**: `.tscn` and `.tres` files can have merge conflicts. See **[GODOT_MERGE_CONFLICTS.md](GODOT_MERGE_CONFLICTS.md)** for detailed instructions.

**Key Rule**: **Never open a conflicted scene in Godot until all conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`) are removed.**

## Questions or Issues?

- **Questions**: Open a GitHub Discussion or ask in the team chat
- **Bugs**: Open a GitHub Issue with reproduction steps
- **Feature Ideas**: Open a GitHub Issue with the `enhancement` label

Thank you for contributing to 4REVERgunner! 🚀
