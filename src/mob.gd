extends CharacterBody2D

var health = 3

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
	health -= 1
	%ProgressBar.show()
	%ProgressBar.value = health
	%Slime.play_hurt()
	
	if health == 0:
		queue_free()
		const SMOKE_EXPLOSION = preload("uid://dhmhmrth6rdce")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		
