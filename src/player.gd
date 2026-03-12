extends CharacterBody2D

# Signals
signal health_depleted

# Variables
var level : int = 1
var experience : int = 1
var maxExperience : int = 10
var speed : int = 600
var maxHealth : float = 100.0
var health : float = maxHealth
var damage : float = 1
var fireRate : float = 0.5

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Player movement
	var direction = Input.get_vector("move_left","move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	# Animation player
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	# Player damage conditions
	const DAMAGE_RATE : float = 50.0
	var overlapping_bodies : Array = %HurtBox.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		health -= DAMAGE_RATE * overlapping_bodies.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
