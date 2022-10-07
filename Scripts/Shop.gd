extends Control

func _ready():
	get_tree().get_root().set_disable_input(false)
	$AnimationPlayer.play("LoadScene")
	yield($AnimationPlayer,"animation_finished")

func _physics_process(delta):
	$Moneylabel.text = str(Global.money)

func _on_button1_pressed():
	if Global.money >= 50:
		Global.money -= 50
		Global.VMHealth += 1
		$ButtonPress.play()
		yield($ButtonPress,"finished")
	else:
		$Error.play()
		yield($Error,"finished")


func _on_button2_pressed():
	if Global.money >= 20:
		Global.money -= 20
		Global.VMShell += 1
		$ButtonPress.play()
		yield($ButtonPress,"finished")
	else:
		$Error.play()
		yield($Error,"finished")


func _on_button3_pressed():
	if Global.money >= 40:
		Global.money -= 40
		Global.VMShield += 1
		$ButtonPress.play()
		yield($ButtonPress,"finished")
	else:
		$Error.play()
		yield($Error,"finished")


func _on_button4_pressed():
	if Global.money >= 30:
		Global.money -= 30
		Global.VMLongAmmo += 1
		$ButtonPress.play()
		yield($ButtonPress,"finished")
	else:
		$Error.play()
		yield($Error,"finished")


func _on_button5_pressed():
	if Global.money >= 60:
		Global.money -= 60
		Global.VMSpeedBoost += 1
		$ButtonPress.play()
		yield($ButtonPress,"finished")
	else:
		$Error.play()
		yield($Error,"finished")


func _on_button6_pressed():
	if Global.money >= 10:
		Global.money -= 10
		Global.VMAmmo += 1
		$ButtonPress.play()
		yield($ButtonPress,"finished")
	else:
		$Error.play()
		yield($Error,"finished")

func _on_BackButton_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	$Transition.visible = true
	get_tree().change_scene("res://Scene/MainHub.tscn")
