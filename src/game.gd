extends Node2D

@onready var player = get_node("/root/Game/Player")

# Variables
var score : int = 0
var aliveMobs = 0

# Timer
var totalSeconds : int = 0
var sec = 0
var min = 0

# Signals
signal hudUpdate
signal pause
signal gameOver

func _on_time_counter_timeout() -> void:
	totalSeconds += 1
	min = int(totalSeconds / 60.0)
	sec = totalSeconds - min * 60

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		emit_signal("pause")
		get_tree().paused = true
	if Input.is_action_just_pressed("enter"):
		player.experience = player.maxExperience
		
func spawn_mob():
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.enemyDeath.connect(_enemy_death)
	# new_mob.player_leveled_up.connect(_on_player_leveled_up)
	# print("Mob spawned at: " + str(new_mob.global_position))
	add_child(new_mob)

func _on_timer_timeout() -> void:
	aliveMobs += 1 
	hudUpdate.emit()
	spawn_mob()
	# print(aliveMobs)

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
	
func _enemy_death(_mobPos):
	# print(mobPos)
	score += 1
	player.experience += 1
	aliveMobs -= 1 
	hudUpdate.emit()
