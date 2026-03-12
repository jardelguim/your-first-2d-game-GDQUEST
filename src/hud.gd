extends Control

@onready var main = get_node("/root/Game")
@onready var player = get_node("/root/Game/Player")


func _ready() -> void:
	$UpgradeContainer.hide()
	$PauseMarginContainer.hide()
	# Debug
	$DebugContainer/DamageLabel.text = "Damage: " + str(player.damage)
	$DebugContainer/HealthLabel.text = "MaxHealth: " + str(player.maxHealth)
	$DebugContainer/SpeedLabel.text = "Speed: " + str(player.speed)
	$DebugContainer/FireRateLabel.text = "Fire rate: " + str(player.fireRate)

func _on_game_hud_update(score , aliveMobs) -> void:
	$LabelContainer/ScoreLabel.text = "Score : " + str(score)
	$DebugContainer/AliveLabel.text = "Alive mobs: " + str(aliveMobs)
	$DebugContainer/ExperienceLabel.text = "Experience : " + str(player.experience) + " , needed : " + str(player.maxExperience)
	
func _on_game_pause() -> void:
	$PauseMarginContainer.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	$PauseMarginContainer.hide()

func _on_game_hud_leveled_up() -> void:
	$LabelContainer/LevelLabel.text = "Level: " + str(player.level)
	_show_upgrade_list()

func _hide_upgrade_list():
	$UpgradeContainer.hide()
	$DebugContainer/DamageLabel.text = "Damage: " + str(player.damage)
	$DebugContainer/HealthLabel.text = "MaxHealth: " + str(player.maxHealth)
	$DebugContainer/SpeedLabel.text = "Speed: " + str(player.speed)
	$DebugContainer/FireRateLabel.text = "Fire rate: " + str(player.fireRate)
	get_tree().paused = false

func _show_upgrade_list():
	$UpgradeContainer.show()
	var button1 = possibleUpgrade.pick_random()
	button1.reparent(get_node("UpgradeContainer"))
	var button2 = possibleUpgrade.pick_random()
	button2.reparent(get_node("UpgradeContainer"))
	var button3 = possibleUpgrade.pick_random()
	button3.reparent(get_node("UpgradeContainer"))
	get_tree().paused = true

# Upgrades

@onready var possibleUpgrade : Array = [
	%DamageButton ,
	%HealthButton ,
	%SpeedButton ,
	%FireRateButton 
	]
	
func _on_damage_button_pressed() -> void:
	player.damage += 1.5
	_hide_upgrade_list()
	
func _on_health_button_pressed() -> void:
	player.maxHealth += 20
	_hide_upgrade_list()
	
func _on_speed_button_pressed() -> void:
	player.speed += 30
	_hide_upgrade_list()

func _on_fire_rate_button_pressed() -> void:
	player.fireRate -= 0.1
	_hide_upgrade_list()
