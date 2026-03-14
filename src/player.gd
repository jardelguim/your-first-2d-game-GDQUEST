extends CharacterBody2D

# Signals
signal health_depleted
signal level_up

# Variables
var level : int = 1
var experience : float = 0.0
var maxExperience : float = 10.0
var speed : int = 350
var maxHealth : float = 50.0
var health : float = maxHealth
var damage : float = 1
var fireRate : float = 0.5

func _ready() -> void:
	%HealthBar.max_value = maxHealth

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
		
	if experience >= maxExperience:
			print("Level up")
			_level_up()
			level_up.emit()
	
	# Player damage conditions
	var DAMAGE_RATE : float = 0.0
	var overlapping_bodies : Array = %HurtBox.get_overlapping_bodies()

	if overlapping_bodies.size() > 0:
		for body in overlapping_bodies:
			if body.has_method("_mob_data"):
				var mob_info = body.call("_mob_data")
				DAMAGE_RATE += mob_info["damage"]

		health -= DAMAGE_RATE * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func _level_up():
	level += 1
	%HealthBar.max_value = maxHealth
	experience = maxExperience
	maxExperience = maxExperience * 1.8
