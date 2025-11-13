extends Node3D

## Main game controller
## Handles player and enemy spawning

# Scene references - assign in Godot Inspector or via code
@export var player_scene: PackedScene = preload("res://scenes/player_placeholder.tscn")
@export var enemy_scene: PackedScene = preload("res://scenes/enemy_placeholder.tscn")

# Spawn configuration
@export var enemy_spawn_interval: float = 2.0  # seconds between enemy spawns
@export var max_enemies: int = 10  # maximum enemies in pool

# Internal state
var enemies: Array = []  # Array to hold active enemy instances
var spawn_timer: float = 0.0
var player_instance: Node3D = null

func _ready() -> void:
	# Spawn the player at start
	spawn_player()

func _process(delta: float) -> void:
	# Handle enemy spawning with timer
	spawn_timer += delta
	if spawn_timer >= enemy_spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

func spawn_player() -> void:
	"""Instantiate the player at the starting position"""
	if player_scene and not player_instance:
		player_instance = player_scene.instantiate()
		# Position player at origin, slightly above ground
		player_instance.position = Vector3(0, 1, 0)
		add_child(player_instance)
		print("Player spawned at position: ", player_instance.position)
	else:
		print("Warning: Player scene not set or player already exists")

func spawn_enemy() -> void:
	"""Spawn an enemy at a random position"""
	# Don't spawn if we've reached the maximum
	if enemies.size() >= max_enemies:
		return
	
	if enemy_scene:
		var enemy = enemy_scene.instantiate()
		# Spawn enemy at random X position, in front of camera
		var random_x = randf_range(-5.0, 5.0)
		enemy.position = Vector3(random_x, 1, -5)
		add_child(enemy)
		enemies.append(enemy)
		print("Enemy spawned at position: ", enemy.position)
	else:
		print("Warning: Enemy scene not set")

func remove_enemy(enemy: Node3D) -> void:
	"""Remove an enemy from the game (called when enemy dies)"""
	if enemy in enemies:
		enemies.erase(enemy)
	enemy.queue_free()
