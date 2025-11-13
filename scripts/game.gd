extends Node3D

## Game Manager Script
## 
## This script handles the main game logic including:
## - Player and enemy spawning
## - Object pooling for performance
## - Game state management

# Scene references for spawning
@export var player_scene: PackedScene
@export var enemy_scene: PackedScene

# Object pools (pre-instantiated objects for performance)
var player_pool: Array = []
var enemy_pool: Array = []

# Spawn timer
var spawn_timer: float = 0.0
var spawn_interval: float = 2.0  # Spawn interval in seconds

# Player instance reference
var player_instance: Node = null


func _ready() -> void:
	"""Initialize the game when the scene is ready"""
	print("Game manager initialized")
	
	# Load player and enemy scenes if not set in editor
	if player_scene == null:
		player_scene = load("res://scenes/player_placeholder.tscn")
	
	if enemy_scene == null:
		enemy_scene = load("res://scenes/enemy_placeholder.tscn")
	
	# Spawn the player at start
	spawn_player()


func _process(delta: float) -> void:
	"""Called every frame"""
	# Update spawn timer
	spawn_timer += delta
	
	# Spawn enemies periodically (placeholder logic)
	# Commented out to keep the initial scene simple
	# if spawn_timer >= spawn_interval:
	# 	spawn_enemy()
	# 	spawn_timer = 0.0


func spawn_player() -> void:
	"""Spawn the player character"""
	if player_scene and player_instance == null:
		player_instance = player_scene.instantiate()
		player_instance.position = Vector3(0, 0, 0)
		add_child(player_instance)
		print("Player spawned at position: ", player_instance.position)


func spawn_enemy() -> void:
	"""Spawn an enemy (placeholder)"""
	if enemy_scene:
		var enemy = enemy_scene.instantiate()
		# Random spawn position
		var spawn_x = randf_range(-5.0, 5.0)
		var spawn_z = randf_range(-10.0, -5.0)
		enemy.position = Vector3(spawn_x, 0, spawn_z)
		add_child(enemy)
		print("Enemy spawned at position: ", enemy.position)
