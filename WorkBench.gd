extends Node2D

var playerinarea = false
var tick = 0

func _ready():
	if self.name == "PowerGenerator":
		$AnimationPlayer.play("PowerOn")
	elif self.name == "ExitDoor":
		$AnimationPlayer.playback_speed = 8
		$Sprite.frame = 0
	elif self.name == "Teleporter":
		$Sprite.frame = 0
		$AnimationPlayer.playback_speed = 3
	else:
		pass
	
	if get_parent().name == "MainHub":
		$Label.visible = true
	else:
		$Label.visible = false

func _physics_process(delta):
	if self.name == "Teleporter":
		if Input.is_action_just_pressed("Interact") and playerinarea == true:
			$Transition.visible = true
			$ButtonPress.play()
			$AnimationPlayer.play("ChangeScene")
			yield($AnimationPlayer,"animation_finished")
			get_tree().change_scene("res://Scene/MainMenu.tscn")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		playerinarea = true
		Global.buildablestate = self.name
		if self.name == "ExitDoor":
			$AnimationPlayer.play("DoorOpen")
		if self.name == "Teleporter" and tick == 0:
			if Global.earthstone == true and Global.waterstone == true and Global.firestone == true:
				$AnimationPlayer.play("Activate")
				tick += 1

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		playerinarea = false
		Global.buildablestate = ""
		if self.name == "ExitDoor":
			$AnimationPlayer.play("DoorClose")
		if self.name == "Teleporter" and tick == 1:
			if Global.earthstone == true and Global.waterstone == true and Global.firestone == true:
				$AnimationPlayer.play("Deactivate")
				tick -= 1
