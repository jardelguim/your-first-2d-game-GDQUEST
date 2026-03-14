extends Area2D

const SPEED = 1000
const RANGE = 1200
var travelled_distance = 0

func _physics_process(delta: float) -> void:
	# Move forward based on the right angle
	var direction = Vector2.RIGHT.rotated(rotation) # Get vector rotated by desired angle
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
	
func _on_body_entered(body): # Triggers on collision with another(any) body
	queue_free()
	var impact = preload("res://pack/pistol/impact/impact.tscn").instantiate()
	impact.global_position = global_position
	get_parent().add_child(impact)
	AudioManager._play_impact_sound(global_position)
	# Checks if colidded body has "take_damage" function
	if body.has_method("take_damage"):
		body.call("take_damage")
