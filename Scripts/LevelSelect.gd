extends Control


func _ready():
	$Music.play()
	if Global.level2 == false:
		$lvl2.disabled = true
	else:
		$lvl2.disabled = false
	if Global.level3 == false:
		$lvl3.disabled = true
	else:
		$lvl3.disabled = false
	if Global.level4 == false:
		$lvl4.disabled = true
	else:
		$lvl4.disabled = false
	if Global.level5 == false:
		$lvl5.disabled = true
	else:
		$lvl5.disabled = false
	$AnimationPlayer.play("LoadScene")
	yield($AnimationPlayer,"animation_finished")

func _on_lvl1_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/level_1.tscn")

func _on_lvl2_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/level_2.tscn")

func _on_lvl3_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/level_3.tscn")

func _on_lvl4_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/level_4.tscn")


func _on_lvl5_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/level_5.tscn")


func _on_BackButton_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/MainHub.tscn")
	
