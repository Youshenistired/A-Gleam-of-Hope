extends Node2D

var playerin = false
onready var Itemscene = preload("res://Scene/Item.tscn")
var rand

func _ready():
	$Sprite.frame = 1
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	while Global.VMAmmo > 0:
		var ammo = Itemscene.instance()
		rand = rand_range(-15,15)
		ammo.name = "Ammo1"
		ammo.position = $Position2D.global_position
		ammo.position.x += rand
		get_parent().add_child(ammo)
		Global.VMAmmo -= 1
	while Global.VMHealth > 0:
		var health = Itemscene.instance()
		rand = rand_range(-15,15)
		health.name = "ExtraHealth1"
		health.position = $Position2D.global_position
		health.position.x += rand
		get_parent().add_child(health)
		Global.VMHealth -= 1
	while Global.VMLongAmmo > 0:
		var longammo = Itemscene.instance()
		rand = rand_range(-15,15)
		longammo.name = "LongAmmo1"
		longammo.position = $Position2D.global_position
		longammo.position.x += rand
		get_parent().add_child(longammo)
		Global.VMLongAmmo -= 1
	while Global.VMShell > 0:
		var shell = Itemscene.instance()
		rand = rand_range(-15,15)
		shell.name = "Shell1"
		shell.position = $Position2D.global_position
		shell.position.x += rand
		get_parent().add_child(shell)
		Global.VMShell -= 1
	while Global.VMShield > 0:
		var shield = Itemscene.instance()
		rand = rand_range(-15,15)
		shield.name = "Shield1"
		shield.position = $Position2D.global_position
		shield.position.x += rand
		get_parent().add_child(shield)
		Global.VMShield -= 1
	while Global.VMSpeedBoost > 0:
		var speedboost = Itemscene.instance()
		rand = rand_range(-15,15)
		speedboost.name = "SpeedBoost1"
		speedboost.position = $Position2D.global_position
		speedboost.position.x += rand
		get_parent().add_child(speedboost)
		Global.VMSpeedBoost -= 1
	
	
	if Input.is_action_just_pressed("Interact") and playerin == true:
		$ButtonPress.play()
		$AnimationPlayer.play("ChangeScene")
		yield($AnimationPlayer,"animation_finished")
		get_tree().change_scene("res://Scene/Shop.tscn")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		playerin = true
		$AnimationPlayer.play("AppearText")
		yield($AnimationPlayer,"animation_finished")

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		playerin = false
		$AnimationPlayer.play("DisapearText")
		yield($AnimationPlayer,"animation_finished")
