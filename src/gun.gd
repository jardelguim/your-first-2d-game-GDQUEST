extends Area2D

func _physics_process(delta: float) -> void:
	# Get enemies inside the collision and creates a array
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		# Points the gun at the closesest enemy
		var target_enemy = enemies_in_range.front()
		# Rotates the gun towards the first entry on the array
		look_at(target_enemy.global_position)
		
func shoot():
	# Preload bullet scene and store in a constant
	const BULLET = preload("res://scenes/bullet.tscn")
	# Instantiate the BULLET into a new variable
	var new_bullet = BULLET.instantiate()
	# Position is relative to the parent node
	# Global position is the absolute position in the entire game world
	# Set the bullet position and rotation to the shooting point
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	# Creates a new_bullet as a chield of Shooting point
	%ShootingPoint.add_child(new_bullet)
	
func _on_timer_timeout() -> void:
	shoot()
