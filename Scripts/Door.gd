extends StaticBody2D

func _ready():
	$AnimationPlayer.playback_speed = 10
	$Sprite.frame = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("DoorOpen")

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("DoorClose")
