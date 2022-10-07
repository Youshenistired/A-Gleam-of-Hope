extends Node2D

var pause = false

func _ready():
	get_tree().get_root().set_disable_input(false)
	$Transition.visible = true
	$Music.play()
	$UI/AnimationPlayer.play("LoadScene")
	yield($UI/AnimationPlayer,"animation_finished")
	$UI/PauseWindow.visible = true

func _physics_process(delta):
	if Input.is_action_just_pressed("Interact"):
		if Global.buildablestate == "ExitDoor": 
			$ExitDoorsfx.play()
			$UI/AnimationPlayer.play("ChangeScene")
			yield($UI/AnimationPlayer,"animation_finished")
			get_tree().change_scene("res://Scene/LevelSelect.tscn")
	
	if Input.is_action_just_pressed("Pause"):
		pause = !pause
		if pause == true:
			$UI/AnimationPlayer2.play("Pause")
			yield($UI/AnimationPlayer2,"animation_finished")
		elif pause == false:
			$UI/AnimationPlayer2.play("Unpause")
			yield($UI/AnimationPlayer2,"animation_finished")


func _on_HomeButton_pressed():
	$UI/PauseWindow.visible = false
	$UI/AnimationPlayer.play("ChangeScene")
	yield($UI/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/MainMenu.tscn")


func _on_SettingsButton_pressed():
	$UI/PauseWindow.visible = false
	$UI/AnimationPlayer.play("ChangeScene")
	yield($UI/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/SettingsMenu.tscn")


func _on_Area2D_body_entered(body):
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	pass # Replace with function body.
