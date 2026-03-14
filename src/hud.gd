extends Control

@onready var main = get_node("/root/Game")
@onready var player = get_node("/root/Game/Player")


func _ready() -> void:
	$XpBar.max_value = player.maxExperience
	$XpBar.min_value = player.experience
	$MarginUpgradeContainer.hide()
	$PauseMarginContainer.hide()
	# Debug
	$DebugContainer/DamageLabel.text = "Damage: " + str(player.damage)
	$DebugContainer/HealthLabel.text = "MaxHealth: " + str(player.maxHealth)
	$DebugContainer/SpeedLabel.text = "Speed: " + str(player.speed)
	$DebugContainer/FireRateLabel.text = "Fire rate: " + str(player.fireRate)

func _on_game_hud_update() -> void:
	$XpBar.value = player.experience
	$DebugContainer/ScoreLabel.text = "Score : " + str(main.score)
	$DebugContainer/AliveLabel.text = "Alive mobs: " + str(main.aliveMobs)
	$DebugContainer/ExperienceLabel.text = "Experience : " + str(player.experience) + " , needed : " + str(player.maxExperience)
	
func _on_player_level_up() -> void:
	$TimerAndLevelMargin/HBoxContainer/LevelLabel.text = "Level: " + str(player.level)
	$XpBar.max_value = player.maxExperience
	$XpBar.min_value = player.experience
	$XpBar.value = $XpBar.min_value
	_show_upgrade_list()
	
func _on_time_counter_timeout() -> void:
	$TimerAndLevelMargin/HBoxContainer/TimerLabel.text = "%02d:%02d" % [main.min , main.sec] 
	
func _on_game_pause() -> void:
	$PauseMarginContainer.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	$PauseMarginContainer.hide()

func _hide_upgrade_list():
	$MarginUpgradeContainer.hide()
	$DebugContainer/DamageLabel.text = "Damage: " + str(player.damage)
	$DebugContainer/HealthLabel.text = "MaxHealth: " + str(player.maxHealth)
	$DebugContainer/SpeedLabel.text = "Speed: " + str(player.speed)
	$DebugContainer/FireRateLabel.text = "Fire rate: " + str(player.fireRate)
	get_tree().paused = false

func _show_upgrade_list():
	$MarginUpgradeContainer.show()
	var button1 = possibleUpgrade.pick_random()
	button1.reparent(get_node("MarginUpgradeContainer/VBoxContainer/UpgradeContainer"))
	var button2 = possibleUpgrade.pick_random()
	button2.reparent(get_node("MarginUpgradeContainer/VBoxContainer/UpgradeContainer"))
	var button3 = possibleUpgrade.pick_random()
	button3.reparent(get_node("MarginUpgradeContainer/VBoxContainer/UpgradeContainer"))
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


func _on_player_health_depleted() -> void:
	pass # Replace with function body.
