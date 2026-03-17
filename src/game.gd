extends Node2D

@onready var player = get_node("/root/Game/Player")

# Variables
var score : int = 0
var aliveMobs = 0
var mob_type

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
	print(min)
	print(sec)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		emit_signal("pause")
		get_tree().paused = true
		
	if Input.is_action_just_pressed("enter"):
		player.experience = player.maxExperience
		
	if Input.is_action_just_pressed("skip_time"):
		print("time skipped")
		totalSeconds += 30
		
func spawn_mob():
	var green_slime = preload("res://scenes/enemies/green_slime.tscn")
	var blue_slime = preload("res://scenes/enemies/blue_slime.tscn")
	var red_slime = preload("res://scenes/enemies/red_slime.tscn")
	if min >= 2 and min < 5:
		mob_type = blue_slime
	elif min >= 4:
		mob_type = red_slime
	else:
		mob_type = green_slime
	var new_mob = mob_type.instantiate()
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
	# %GameOver.visible = true
	gameOver.emit()
	get_tree().paused = true

func _enemy_death(_mobPos):
	# print(mobPos)
	score += 1
	player.experience += 1
	aliveMobs -= 1 
	hudUpdate.emit()
