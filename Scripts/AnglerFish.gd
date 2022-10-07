extends KinematicBody2D

const KNOCKBACK = 80
const UP = Vector2(0, -1)
const MAXSPEED = 150

var facing_right = false
var health = 50
var motion = Vector2()
var playerdetect = false
var damage = 10
var rand 
var randpos
onready var coin = preload("res://Scene/Coin.tscn")

func _ready():
	rand = rand_range(3, 10)
	var randscale = round(rand_range(2, 3))
	scale.y = randscale
	scale.x = randscale

func _physics_process(delta):
	if playerdetect == true:
		Global.emo = true
	if health <= 0:
		while rand > 0:
			var coindrop = coin.instance()
			randpos = rand_range(-30, 30)
			coindrop.position = global_position
			coindrop.position.x += randpos
			get_parent().add_child(coindrop)
			rand -= 1
		
		Global.emo = false
		queue_free()
	var player = get_parent().get_node("Player")
	if player:
		if (player.position.x - position.x) > 0:
			facing_right = true
		elif (player.position.x - position.x) < 0:
			facing_right = false
	else:
		pass
	
	if facing_right == true:
		$Sprite.scale.x = -1
	elif facing_right == false:
		$Sprite.scale.x = 1
	
	if motion.x > MAXSPEED and facing_right == true:
		motion.x = MAXSPEED
	if motion.x < -MAXSPEED and facing_right == false:
		motion.x = -MAXSPEED
	if motion.y > MAXSPEED:
		motion.y = MAXSPEED
	if motion.y < -MAXSPEED:
		motion.y = MAXSPEED
	
	if playerdetect == true and player:
		player.get_position_in_parent()
		motion += (player.global_position - global_position)/30
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
	elif area.is_in_group("Player"):
		if Global.shield == true:
			Global.shieldhealth -= damage
		else:
			Global.health -= damage

func _on_Area2D_area_exited(area):
	pass

func _on_Area2D2_body_entered(body):
	if body != null and body.is_in_group("Player"):
		playerdetect = true

func _on_Area2D_body_entered(body):
	if body != null and body.is_in_group("Player"):
		if Global.shield == true:
			Global.shieldhealth -= damage
		else:
			Global.health -= damage
		Global.camera.shake(100)
		$HitPlayer.play()
