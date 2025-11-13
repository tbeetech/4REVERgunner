# 4REVERgunner

An endless 3D shooter game built with Godot 4, featuring a placeholder character that you can replace with custom MakeHuman + Blender assets.

## Prerequisites

Before you begin, make sure you have the following installed:

- **Godot 4** - Download from [godotengine.org](https://godotengine.org/download)
- **Git** - For version control
- **Git LFS** (Large File Storage) - For managing binary assets
- **Blender** (optional) - For editing 3D models
- **MakeHuman** (optional) - For creating custom characters

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/tbeetech/4REVERgunner.git
cd 4REVERgunner
```

### 2. Set Up Git LFS

Git LFS is used to handle large binary files like 3D models and textures. Install and configure it:

```bash
# Install Git LFS (first time only)
# On Ubuntu/Debian:
sudo apt-get install git-lfs

# On macOS with Homebrew:
brew install git-lfs

# On Windows, download from: https://git-lfs.github.com/

# Initialize Git LFS in your repository
git lfs install

# Pull LFS-tracked files
git lfs pull
```

### 3. Open the Project in Godot 4

1. Launch Godot 4
2. Click **Import**
3. Navigate to the cloned `4REVERgunner` folder
4. Select the `project.godot` file
5. Click **Import & Edit**

### 4. Configure Input Map

The game uses a custom "shoot" action that needs to be set up:

1. In Godot, go to **Project → Project Settings**
2. Click on the **Input Map** tab
3. In the "Add New Action" field at the top, type `shoot` and click **Add**
4. Find `shoot` in the action list, click the **+** button next to it
5. Press **Space** on your keyboard when prompted
6. Click **OK** to confirm

### 5. Run the Game

- Click the **Play** button (▶) in the top-right corner, or press **F5**
- The main scene (`scenes/main.tscn`) will launch
- Use **Arrow Keys** to move left/right
- Press **Space** to shoot (currently just prints to console)

## Project Structure

```
4REVERgunner/
├── scenes/           # Game scenes (.tscn files)
│   ├── main.tscn              # Main game scene
│   ├── player_placeholder.tscn # Placeholder player
│   └── enemy_placeholder.tscn  # Placeholder enemy
├── scripts/          # GDScript files (.gd)
│   ├── game.gd               # Main game logic
│   └── player.gd             # Player controller
├── README.md         # This file
└── project.godot     # Godot project configuration
```

## Basic Git Commands

```bash
# Check status of your changes
git status

# Stage all changes
git add .

# Commit with a message
git commit -m "your message here"

# Push to remote
git push

# Pull latest changes
git pull

# Create a new branch
git checkout -b feature/your-feature-name

# Switch branches
git checkout branch-name
```

## Troubleshooting

### "Cannot open project" or "Project file missing"
- Make sure you selected the `project.godot` file when importing
- Check that you're in the correct directory

### "Invalid scene" or "Failed to load resource"
- Run `git lfs pull` to ensure all binary assets are downloaded
- Check that all `.tscn` files are present in the `scenes/` folder

### Input action "shoot" not found
- Follow step 4 above to add the "shoot" action to the Input Map
- Make sure you saved the Project Settings after adding it

### Enemies not spawning
- Check the Output panel (bottom of Godot) for error messages
- Make sure `scenes/enemy_placeholder.tscn` exists

### Git LFS files not downloading
```bash
# Reinstall LFS hooks
git lfs install --force

# Pull LFS files again
git lfs pull
```

## Next Steps

- Read `ASSET_PIPELINE_MAKEHUMAN.md` to learn how to create custom characters
- Check `CONTRIBUTING.md` for guidelines on contributing to the project
- See `README_ASSETS.md` for free asset resources

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
