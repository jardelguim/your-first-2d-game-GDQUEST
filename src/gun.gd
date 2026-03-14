extends Area2D

# Signals
# signal shooted

# Variables
var isEnemiesInRange = false
var fireRate = 0.5

func _change_fire_rate():
	fireRate = get_parent().fireRate
	$Timer.wait_time = fireRate

func _physics_process(_delta: float) -> void:
	# Get enemies inside the collision and creates a array
	var enemies_in_range = get_overlapping_bodies()
	print(enemies_in_range)
	if enemies_in_range.size() > 0:
		isEnemiesInRange = true
		# Points the gun at the closesest enemy
		var target_enemy = enemies_in_range.front()
		# Rotates the gun towards the first entry on the array
		look_at(target_enemy.global_position)
	else:
		isEnemiesInRange = false
		
func shoot():
	_change_fire_rate()
	# Preload bullet scene and store in a constant
	const BULLET = preload("res://scenes/bullet.tscn")
	const MUZZLE = preload("res://pack/pistol/muzzle_flash/muzzle_flash.tscn")
	# Instantiate the BULLET into a new variable
	var new_bullet = BULLET.instantiate()
	var muzzleFlash = MUZZLE.instantiate() 
	# Position is relative to the parent node
	# Global position is the absolute position in the entire game world
	# Set the bullet position and rotation to the shooting point
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	muzzleFlash.global_position = %ShootingPoint.global_position
	muzzleFlash.global_rotation = %ShootingPoint.global_rotation
	# Creates a new_bullet as a chield of Shooting point
	%ShootingPoint.add_child(muzzleFlash)
	%ShootingPoint.add_child(new_bullet)
	$Shoot.play()
	
func _on_timer_timeout() -> void:
	if isEnemiesInRange == true:
		shoot()
