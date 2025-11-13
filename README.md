# 4REVERgunner

An endless shooter game built with Godot 4, featuring custom character assets created with the MakeHuman + Blender pipeline.

## Project Description

4REVERgunner is a beginner-friendly endless shooter game project that demonstrates how to use Godot 4 with custom 3D character assets. This repository includes a complete asset pipeline workflow using MakeHuman for character creation and Blender for asset refinement.

## Prerequisites

Before you start, make sure you have the following tools installed:

- **Godot 4.x** - Download from [godotengine.org](https://godotengine.org/download)
- **MakeHuman** - Download from [makehumancommunity.org](http://www.makehumancommunity.org/content/downloads.html)
- **Blender 3.x+** - Download from [blender.org](https://www.blender.org/download/)
- **Git** - Version control system ([git-scm.com](https://git-scm.com/downloads))
- **Git LFS** - Large File Storage for binary assets ([git-lfs.github.com](https://git-lfs.github.com/))

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/tbeetech/4REVERgunner.git
cd 4REVERgunner
```

### 2. Set Up Git LFS (for large binary assets)

```bash
# Install Git LFS (if not already installed)
# On Ubuntu/Debian: sudo apt-get install git-lfs
# On macOS: brew install git-lfs
# On Windows: download installer from git-lfs.github.com

# Initialize Git LFS in the repository
git lfs install

# Pull any LFS-tracked files
git lfs pull
```

### 3. Open the Project in Godot 4

1. Launch Godot 4
2. Click **Import** on the project manager
3. Navigate to the cloned repository folder
4. Select the `project.godot` file
5. Click **Import & Edit**

### 4. Configure Input Map (First-Time Setup)

The project uses a custom "shoot" action that needs to be configured:

1. In Godot, go to **Project** → **Project Settings**
2. Navigate to the **Input Map** tab
3. In the "Add New Action" field at the top, type: `shoot`
4. Click **Add**
5. Click the **+** button next to the newly created "shoot" action
6. Select **Key** from the dropdown
7. Press the **Space** key when prompted
8. Click **OK**

### 5. Run the Placeholder Scene

1. In the Godot editor, open `res://scenes/main.tscn` (double-click in the FileSystem panel)
2. Click the **Play** button (▶️) at the top right, or press **F5**
3. You should see a simple 3D scene with a placeholder character
4. Use **Arrow Keys** (Left/Right) to move
5. Press **Space** to shoot (outputs to console)

## Making Changes

### Basic Git Workflow

```bash
# Create a new branch for your feature
git checkout -b feature/your-feature-name

# Make your changes, then stage them
git add .

# Commit with a descriptive message
git commit -m "feat: add your feature description"

# Push to GitHub
git push origin feature/your-feature-name
```

### Using Git LFS for Large Assets

When adding large binary files (.glb, .png, .jpg, etc.):

```bash
# These file types are already tracked by LFS (see .gitattributes)
# Just add and commit as usual
git add assets/models/character.glb
git commit -m "feat: add new character model"
git push
```

## Asset Pipeline

For detailed instructions on creating character assets with MakeHuman and Blender, see:
- **[ASSET_PIPELINE_MAKEHUMAN.md](ASSET_PIPELINE_MAKEHUMAN.md)** - Step-by-step asset creation workflow

For team collaboration guidelines, see:
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Team workflow and best practices

## Troubleshooting

### Project Won't Open in Godot
- Make sure you're using **Godot 4.x** (not Godot 3.x)
- Check that `project.godot` exists in the root directory
- Try reimporting: delete the `.godot` folder and reopen the project

### Input Actions Not Working
- Verify you've added the "shoot" action in Project Settings → Input Map
- The built-in actions (ui_left, ui_right) should work by default

### Git LFS Files Not Downloading
- Run `git lfs install` to initialize LFS
- Run `git lfs pull` to download LFS-tracked files
- Check if Git LFS is installed: `git lfs version`

### Scene Merge Conflicts
- See **[GODOT_MERGE_CONFLICTS.md](GODOT_MERGE_CONFLICTS.md)** for detailed resolution steps
- **Important**: Never open conflicted .tscn files in Godot until merge markers are removed

### Character Models Not Showing
- Check that textures are in the correct relative path
- Verify the .glb file imported correctly (check the Import panel)
- See **[ASSET_PIPELINE_MAKEHUMAN.md](ASSET_PIPELINE_MAKEHUMAN.md)** for export troubleshooting

## Additional Resources

- **[COST_AND_REQUIREMENTS.md](COST_AND_REQUIREMENTS.md)** - Project cost analysis and requirements
- **[README_ASSETS.md](README_ASSETS.md)** - Free asset sources and licensing
- **[LICENSE](LICENSE)** - MIT license terms

## Project Structure

```
4REVERgunner/
├── scenes/           # Godot scene files (.tscn)
│   ├── main.tscn
│   ├── player_placeholder.tscn
│   └── enemy_placeholder.tscn
├── scripts/          # GDScript files (.gd)
│   ├── game.gd
│   └── player.gd
├── assets/           # (To be added) Models, textures, audio
├── project.godot     # Godot project file
└── README.md         # This file
```

## Next Steps

1. ✅ Clone the repository and open in Godot 4
2. ✅ Run the main scene to see the placeholder
3. 📖 Read **[ASSET_PIPELINE_MAKEHUMAN.md](ASSET_PIPELINE_MAKEHUMAN.md)** to learn the asset workflow
4. 🎨 Create your first character in MakeHuman
5. 🔧 Export the character through Blender to .glb format
6. 🎮 Import the .glb into Godot and replace the placeholder
7. 🚀 Start building your endless shooter!

## Contributing

Please read **[CONTRIBUTING.md](CONTRIBUTING.md)** for details on our team workflow, branching strategy, and code of conduct.

## License

This project is licensed under the MIT License - see the **[LICENSE](LICENSE)** file for details.
