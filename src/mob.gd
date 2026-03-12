extends CharacterBody2D

# Signals
signal enemyDeath
signal player_leveled_up

# Variables
var health : float = 3
var experienceGiven : int = 1

# Gets the player node at the start of the game
@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	%Slime.play_walk()
	%ProgressBar.hide()
	
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	move_and_slide()
	
func take_damage():
	health -= player.damage
	%ProgressBar.show()
	%ProgressBar.value = health
	%Slime.play_hurt()
	
	if health <= 0:
		queue_free()
		player.experience += experienceGiven
		if player.experience >= player.maxExperience:
			print("Level up")
			emit_signal("player_leveled_up")
		emit_signal("enemyDeath" , global_position)
		const SMOKE_EXPLOSION = preload("uid://dhmhmrth6rdce")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		
