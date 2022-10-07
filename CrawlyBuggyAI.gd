extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 100
const MAXSPEED = 250
const KNOCKBACK = 200

var facing_right = false
var health = 20
var motion = Vector2()
var playerdetect = false
var damage = 5

var rand 
var randpos
onready var coin = preload("res://Scene/Coin.tscn")

func _ready():
	rand = rand_range(2, 10)
	$AnimationPlayer.play("IdleBug")

func _physics_process(delta):
	if health <= 0:
		while rand > 0:
			var coindrop = coin.instance()
			randpos = rand_range(-30, 30)
			coindrop.position = global_position
			coindrop.position.x += randpos
			get_parent().add_child(coindrop)
			rand -= 1
		queue_free()
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	var player = get_parent().get_node("Player")
	if player:
		if (player.position.x - position.x) > 0:
			facing_right = true
		elif (player.position.x - position.x) < 0:
			facing_right = false
	
	if facing_right == true:
		$Sprite.scale.x = -1
	elif facing_right == false:
		$Sprite.scale.x = 1
	
	if motion.x > MAXSPEED and facing_right == true:
		motion.x = MAXSPEED
	if motion.x < -MAXSPEED and facing_right == false:
		motion.x = -MAXSPEED
	
	if playerdetect == true and player:
		$AnimationPlayer.play("RunBug")
		player.get_position_in_parent()
		motion.x += (player.global_position.x - global_position.x)/4
	elif player == null:
		pass
	motion = move_and_slide(motion, UP)


func _on_Area2D_area_entered(area):
	if area.is_in_group("Attack"):
		var player = get_parent().get_node("Player")
		player.get_position_in_parent()
		if (player.global_position.x - global_position.x) > 0:
			motion.x = -KNOCKBACK
		elif (player.global_position.x - global_position.x) < 0:
			motion.x = KNOCKBACK
		$Damage.play()
		yield($Damage,"finished")
		health -= Global.damage

func _on_Area2D2_body_entered(body):
	if body.is_in_group("Player"):
		playerdetect = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if Global.shield == true:
			Global.shieldhealth -= damage
		else:
			Global.health -= damage
		Global.camera.shake(100)
		$HitPlayer.play()
