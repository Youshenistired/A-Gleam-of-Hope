extends Node2D

var ladderabove = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		Global.onladder = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player") and ladderabove == false:
		Global.onladder = false

func _on_DetectLadder_area_entered(area):
	if area.is_in_group("Ladder"):
		ladderabove = true


func _on_Side_body_exited(body):
	if body.is_in_group("Player"):
		Global.onladder = false

func _on_Side2_body_exited(body):
	if body.is_in_group("Player"):
		Global.onladder = false

func _on_Side_body_entered(body):
	if body.is_in_group("Player"):
		Global.onladder = false

func _on_Side2_body_entered(body):
	if body.is_in_group("Player"):
		Global.onladder = false

func _on_Side_area_entered(area):
	if area.is_in_group("Ladder"):
		$Side/CollisionShape2D.disabled = true

func _on_Side2_area_entered(area):
	if area.is_in_group("Ladder"):
		$Side2/CollisionShape2D.disabled = true

