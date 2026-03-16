extends CharacterBody2D
class_name MobBase

# Signals
signal enemyDeath
@export var health : float = 3
@export var speed : float = 200
@export var experienceGiven : int = 1
@export var damage : float = 5

# Gets the player node at the start of the game
@onready var player = get_node("/root/Game/Player")

func _mob_data() -> Dictionary:
	return {
		"health": health,
		"speed": speed,
		"experienceGiven": experienceGiven,
		"damage": damage
	}

func _ready() -> void:
	%MobSprite.play_walk()
	%ProgressBar.hide()
	%ProgressBar.value = health
	
func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
func take_damage():
	health -= player.damage
	%ProgressBar.show()
	var tween = get_tree().create_tween()
	tween.tween_property(%ProgressBar, "value", health, 0.2).set_trans(Tween.TRANS_LINEAR)
	# %ProgressBar.value = health
	$MobSprite.play_hurt()
	
	if health <= 0:
		queue_free()
		player.experience += experienceGiven
		emit_signal("enemyDeath" , global_position)
		const SMOKE_EXPLOSION = preload("uid://dhmhmrth6rdce")
		var smoke = SMOKE_EXPLOSION.instantiate()
		AudioManager._play_explosion_sound(global_position)
		get_parent().add_child(smoke)
		smoke.global_position = global_position
