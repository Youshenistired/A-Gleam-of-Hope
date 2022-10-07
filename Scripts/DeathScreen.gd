extends Control

func _ready():
	if self.name == "DeathScreen":
		Global.health = 100
		Global.level2 = false
		Global.level3 = false
		Global.level4 = false
		Global.level5 = false
		Global.shell = 10
		Global.ammo = 10
		Global.longammo = 5
		Global.money = 50
	$Timer.start()
	$AnimationPlayer.play("LoadScene")
	yield($AnimationPlayer,"animation_finished")


func _on_Timer_timeout():
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/MainHub.tscn")
