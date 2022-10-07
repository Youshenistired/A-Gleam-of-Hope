extends RigidBody2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		Global.money += 1
		$Collect.play()
		$AnimationPlayer.play("Collect")
		yield($AnimationPlayer,"animation_finished")
		queue_free()

