extends CharacterBody3D

## Player controller
## Handles horizontal movement and shooting input

# Movement configuration
@export var speed: float = 5.0  # Movement speed in units per second
@export var move_boundary: float = 8.0  # How far left/right player can move

func _ready() -> void:
	print("Player ready! Use Left/Right arrows to move, Space to shoot")

func _physics_process(delta: float) -> void:
	# Get horizontal input (-1 for left, 1 for right, 0 for no input)
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Apply movement
	if direction != 0:
		velocity.x = direction * speed
	else:
		# Stop moving when no input
		velocity.x = 0
	
	# Apply the velocity using Godot's built-in physics
	move_and_slide()
	
	# Clamp player position to boundaries (prevent going off-screen)
	position.x = clamp(position.x, -move_boundary, move_boundary)

func _input(event: InputEvent) -> void:
	# Handle shooting input
	# Note: Make sure 'shoot' action is defined in Project Settings -> Input Map
	if event.is_action_pressed("shoot"):
		shoot()

func shoot() -> void:
	"""Called when player presses shoot button"""
	print("Shoot! (Space pressed)")
	# TODO: Implement actual shooting behavior
	# For now, just print to console to verify input is working
