extends Control


func _ready():
	$AnimationPlayer.play("LoadScene")


func _on_BackButton_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/MainMenu.tscn")
