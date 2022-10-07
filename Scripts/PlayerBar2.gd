extends Node2D


func _physics_process(delta):
	$MoneyLabel.text = str(Global.money)
	
