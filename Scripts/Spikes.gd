extends Area2D

var playerin = false

func _physics_process(delta):
	if playerin == true:
		$Timer.start()
		playerin = false


func _on_Spikes_body_entered(body):
	Global.health -= 10
	if body.is_in_group("Player"):
		playerin = true
		$CollisionShape2D.visible = false


func _on_Timer_timeout():
	Global.health -= 10
	$CollisionShape2D.visible = true
	if playerin == true:
		$Timer.wait_time = 0.5
		$Timer.start()
