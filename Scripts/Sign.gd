extends Node2D

func _ready():
	$Label.modulate.a = 0
	$AnimationPlayer.playback_speed = 2

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("TextAppear")
		yield($AnimationPlayer,"animation_finished")


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("TextDisappear")
		yield($AnimationPlayer,"animation_finished")
