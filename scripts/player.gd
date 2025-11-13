extends CharacterBody3D

## Player Controller Script
##
## Handles player movement and shooting actions.
## Uses Input actions: ui_left, ui_right (built-in) and shoot (custom).

# Movement settings
@export var speed: float = 5.0
@export var movement_range: float = 8.0  # How far left/right the player can move

# Shooting settings
var can_shoot: bool = true
var shoot_cooldown: float = 0.5  # Cooldown between shots in seconds
var cooldown_timer: float = 0.0


func _ready() -> void:
	"""Initialize the player"""
	print("Player ready")


func _physics_process(delta: float) -> void:
	"""Called every physics frame for movement"""
	# Handle horizontal movement (left/right)
	var direction: float = 0.0
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1.0
	
	if Input.is_action_pressed("ui_right"):
		direction += 1.0
	
	# Apply movement
	if direction != 0.0:
		velocity.x = direction * speed
	else:
		velocity.x = 0.0
	
	# Clamp position to movement range
	var new_x = clamp(position.x + velocity.x * delta, -movement_range, movement_range)
	position.x = new_x
	
	# Update cooldown timer
	if not can_shoot:
		cooldown_timer -= delta
		if cooldown_timer <= 0.0:
			can_shoot = true
	
	# Handle shooting
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()


func shoot() -> void:
	"""Handle shooting action"""
	print("Player shoots! (position: ", position, ")")
	can_shoot = false
	cooldown_timer = shoot_cooldown
	
	# TODO: Spawn projectile here
	# For now, just print to console
