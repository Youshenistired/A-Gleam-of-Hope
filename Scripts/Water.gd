extends Sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		Global.InWater = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		Global.InWater = false
