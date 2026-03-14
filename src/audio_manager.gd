extends Node2D

@onready var explosionSound : AudioStreamPlayer2D = get_node("ExplosionSound")
@onready var impactSound : AudioStreamPlayer2D = get_node("ImpactSound")


func _ready() -> void:
	pass

func _play_explosion_sound(soundPos):
	explosionSound.global_position = soundPos
	explosionSound.play()
	
func _play_impact_sound(soundPos):
	impactSound.global_position = soundPos
	impactSound.play()
	
