extends Control

@onready var main = get_node("/root/Game")

func _ready() -> void:
	$UpgradeContainer.hide()
	$PauseMarginContainer.hide()

func _on_game_hud_update(score , aliveMobs) -> void:
	$LabelContainer/ScoreLabel.text = "Score : " + str(score)
	$LabelContainer/AliveLabel.text = "Alive mobs: " + str(aliveMobs)

func _on_game_pause() -> void:
	$PauseMarginContainer.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	$PauseMarginContainer.hide()
