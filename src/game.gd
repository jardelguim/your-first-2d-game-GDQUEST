extends Node2D

var score : int = 0
var aliveMobs
signal hudUpdate
signal pause

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		emit_signal("pause")
		get_tree().paused = true

func spawn_mob():
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.enemyDeath.connect(_enemy_death)
	# print("Mob spawned at: " + str(new_mob.global_position))
	add_child(new_mob)

func _on_timer_timeout() -> void:
	aliveMobs = get_child_count()
	emit_signal("hudUpdate" , score , aliveMobs)
	spawn_mob()
	print(aliveMobs)

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
	
func _enemy_death(mobPos):
	print(mobPos)
	score += 1
	emit_signal("hudUpdate" , score , aliveMobs)
