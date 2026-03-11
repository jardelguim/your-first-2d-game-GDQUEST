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
	print("Bullet hit!")
	print(body.name)
	queue_free()
	# Checks if colidded body has "take_damage" function
	if body.has_method("take_damage"):
		body.call("take_damage")
