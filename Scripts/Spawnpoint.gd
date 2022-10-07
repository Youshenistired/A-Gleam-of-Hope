extends Area2D


func _on_Spawnpoint_body_entered(body):
	if body.is_in_group("Player"):
		setspawn()

func setspawn():
	Global.spawnpointx = $Position2D.global_position.x
	Global.spawnpointy = $Position2D.global_position.y

