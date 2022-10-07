extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _physics_process(delta):
	global_position = get_global_mouse_position()
	$Sprite.frame = 0
	if Input.is_action_just_pressed("Attack") and Global.abletoclick == true:
		$AnimationPlayer.playback_speed = 4
		$AnimationPlayer.play("Shoot")
		yield($AnimationPlayer,"animation_finished")

