extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 25
const MAXFALLSPEED = 300
const MAXSPEED = 230
const MAXJUMPFORCE = 500
const JUMPFORCE = 620
const ACCEL = 20
const DASHSPEED = 1000
const DASHLENGTH = 0.1
const CLIMB = 90
const RECOIL = 550

onready var dash = $Dash

var facing_right = true
var motion = Vector2()
var jumpcancel = false
var double_jump = 0
var attacking = false
var secondattack = true
var dashing = false
var able_to_attack = true
var able_to_dash = true

var lookup = false
var lookdown = false
var bulletscene = preload("res://Scene/Bullet.tscn")
var bulletspeed = 800

func _ready():
	$AnimationPlayer.playback_speed = 5
	$Sprite/AttackHitBox/CollisionShape2D.disabled = true

func _physics_process(delta):
	var speed = DASHSPEED if dash.is_dashing() else ACCEL
	$Sprite/Head.look_at(get_global_mouse_position())
	$Sprite/BackHand.look_at(get_global_mouse_position())
	if $Sprite/Head.rotation_degrees > 90:
		if $Sprite/Head.rotation_degrees > 180:
			$Sprite/Head.rotation_degrees -= 180
		$Sprite/Head.flip_v = true
	elif $Sprite/Head.rotation_degrees < -90:
		if $Sprite/Head.rotation_degrees < -180:
			$Sprite/Head.rotation_degrees += 180
		$Sprite/Head.flip_v = true
	else:
		$Sprite/Head.flip_v = false
	
	if $Sprite/BackHand.rotation_degrees > 90:
		if $Sprite/BackHand.rotation_degrees > 180:
			$Sprite/BackHand.rotation_degrees -= 180
		$Sprite/BackHand.flip_v = true
	elif $Sprite/BackHand.rotation_degrees < -90:
		if $Sprite/BackHand.rotation_degrees < -180:
			$Sprite/BackHand.rotation_degrees += 180
		$Sprite/BackHand.flip_v = true
	else:
		$Sprite/BackHand.flip_v = false
	
	if Global.weaponselect == 0 or Global.weaponselect == 6:
		$Sprite/Head.visible = false
		$Sprite/BackHand.visible = false
	else:
		$Sprite/Head.visible = true
		$Sprite/BackHand.visible = true
		$Sprite/BackHand.frame = Global.weaponselect - 1
		if (get_global_mouse_position().x - global_position.x) < 0:
			facing_right = false
		else:
			facing_right = true

	
	if Global.health <= 0:
		get_tree().get_root().set_disable_input(true)
		$AnimationPlayer.play("Player Death")
		yield($AnimationPlayer,"animation_finished")
		get_tree().get_root().set_disable_input(false)
		queue_free()
		
	if is_on_floor():
		jumpcancel = false
		double_jump = 0
	
	$AnimationPlayer.playback_speed = 1

	#constantly pull playet's Y axis with gravity
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	

	if motion.x > MAXSPEED:
		motion.x = MAXSPEED
	if motion.x < -MAXSPEED:
		motion.x = -MAXSPEED


	if Input.is_action_pressed("Right"):
		motion.x += speed
		facing_right = true
		$AnimationPlayer.playback_speed = 1.2
		if Global.weaponselect == 0 or Global.weaponselect == 6:
			if attacking == false:
				$AnimationPlayer.play("Walk (freehand)")
		else:
			if attacking == false:
				$AnimationPlayer.play("Idle (holdgun)")
	elif Input.is_action_pressed("Left"):
		motion.x -= speed
		facing_right = false
		$AnimationPlayer.playback_speed = 1.2
		if Global.weaponselect == 0 or Global.weaponselect == 6:
			if attacking == false:
				$AnimationPlayer.play("Walk (freehand)")
		else:
			if attacking == false:
				$AnimationPlayer.play("Idle (holdgun)")
	else:
		motion.x = lerp(motion.x,0,0.2)
		if Global.weaponselect == 0 or Global.weaponselect == 6:
			if attacking == false:
				$AnimationPlayer.play("Idle")
		else:
			if attacking == false:
				$AnimationPlayer.play("Idle (holdgun)")
	
	if Input.is_action_pressed("Jump"):
		if Global.onladder == true:
			motion.y = -CLIMB
		elif is_on_floor():
			motion.y = -JUMPFORCE
	if Input.is_action_just_pressed("Jump"):
		if double_jump == 1 and Global.doublejump == true:
			motion.y = -JUMPFORCE
		double_jump += 1
		
	if Input.is_action_just_released("Jump") and motion.y < 0:
		motion.y = -5
		
	if Global.weaponselect == 0 or Global.weaponselect == 6:
		if attacking == false:
			if !is_on_floor():
				if motion.y < 0:
					$AnimationPlayer.play("Jump")
				elif motion.y > 0:
					$AnimationPlayer.play("Fall")
	motion = move_and_slide(motion, UP)
	
	if Input.is_action_pressed("lookup"):
		lookup = true
	else:
		lookup = false
	
	if Input.is_action_pressed("lookdown"):
		lookdown = true
	else:
		lookdown = false
	
	if Input.is_action_just_pressed("Dash"):
		if able_to_dash == true and Global.dash == true:
			dash.start_dash($Sprite, DASHLENGTH)
			able_to_dash = false
			$DashCooldown.wait_time = Global.dashcooldown
			$DashCooldown.start()
	
	
	if Input.is_action_just_pressed("Attack"):
		if able_to_attack == true:
			$AttackCooldown.wait_time = 1.00 / Global.attackcooldown
			secondattack = !secondattack
			if Global.weaponselect == 0:
				$AnimationPlayer.playback_speed = 8
				attacking = true
				$AttackCooldown.start()
				able_to_attack = false
				if lookup == true:
					$AnimationPlayer.play("Upslash")
					yield($AnimationPlayer,"animation_finished")
				elif lookdown == true and !is_on_floor():
					$AnimationPlayer.play("Downslash")
					yield($AnimationPlayer,"animation_finished")
				else:
					$AnimationPlayer.play("Attack")
					yield($AnimationPlayer,"animation_finished")
				attacking = false
				$AnimationPlayer.playback_speed = 1
			elif Global.weaponselect == 6:
				$AnimationPlayer.playback_speed = 15
				attacking = true
				$AttackCooldown.start()
				able_to_attack = false
				if lookup == true:
					$AnimationPlayer.play("BigUpslash")
					yield($AnimationPlayer,"animation_finished")
				elif lookdown == true and !is_on_floor():
					$AnimationPlayer.play("BigDownslash")
					yield($AnimationPlayer,"animation_finished")
				elif secondattack == false:
					$AnimationPlayer.play("BigAttack1")
					yield($AnimationPlayer,"animation_finished")
				elif secondattack == true:
					$AnimationPlayer.play("BigAttack2")
					yield($AnimationPlayer,"animation_finished")
				attacking = false
				$AnimationPlayer.playback_speed = 1
			elif Global.weaponselect == 1:
				if Global.pistolammo > 0:
					attacking = true
					$AttackCooldown.start()
					able_to_attack = false
					fire()
					$Fire.play()
					$AnimationPlayer.play("PistolFire")
					yield($AnimationPlayer,"animation_finished")
					attacking = false
				else:
					Global.abletoclick = false
					$Error.play()
					yield($Error,"finished")
			elif Global.weaponselect == 2:
				if Global.dbshotgunammo > 0:
					attacking = true
					$AttackCooldown.start()
					able_to_attack = false
					fire()
					$Fire.play()
					$AnimationPlayer.play("dbShotgunFire")
					yield($AnimationPlayer,"animation_finished")
					attacking = false
				else:
					Global.abletoclick = false
					$Error.play()
					yield($Error,"finished")
			elif Global.weaponselect == 3:
				if Global.lrshotgunammo > 0:
					attacking = true
					$AttackCooldown.start()
					able_to_attack = false
					fire()
					$Fire.play()
					$AnimationPlayer.play("lrShotgunFire")
					yield($AnimationPlayer,"animation_finished")
					attacking = false
				else:
					Global.abletoclick = false
					$Error.play()
					yield($Error,"finished")
			elif Global.weaponselect == 4:
				if Global.rifleammo > 0:
					attacking = true
					$AttackCooldown.start()
					able_to_attack = false
					fire()
					$Fire.play()
					$AnimationPlayer.play("RifleFire")
					yield($AnimationPlayer,"animation_finished")
					attacking = false
				else:
					Global.abletoclick = false
					$Error.play()
					yield($Error,"finished")
			elif Global.weaponselect == 5:
				if Global.sniperammo > 0:
					attacking = true
					$AttackCooldown.start()
					able_to_attack = false
					fire()
					$Fire.play()
					$AnimationPlayer.play("SniperFire")
					yield($AnimationPlayer,"animation_finished")
					attacking = false
				else:
					Global.abletoclick = false
					$Error.play()
					yield($Error,"finished")
	
	if Input.is_action_just_pressed("Reload"):
		if Global.weaponselect == 1:
			if Global.ammo > 0:
				Global.ammo -= 1
				Global.abletoclick = false
				$Reload.play()
				yield($Reload,"finished")
				Global.pistolammo = Global.maxpistolammo
		elif Global.weaponselect == 2:
			if Global.shell > 0:
				Global.shell -= 1
				Global.abletoclick = false
				$Reload.play()
				yield($Reload,"finished")
				Global.dbshotgunammo = Global.maxdbshotgunammo
		elif Global.weaponselect == 3:
			if Global.shell > 0:
				Global.shell -= 1
				Global.abletoclick = false
				$Reload.play()
				yield($Reload,"finished")
				Global.lrshotgunammo = Global.maxlrshotgunammo
		elif Global.weaponselect == 4:
			if Global.ammo > 0:
				Global.ammo -= 1
				Global.abletoclick = false
				$Reload.play()
				yield($Reload,"finished")
				Global.rifleammo = Global.maxrifleammo
		elif Global.weaponselect == 5:
			if Global.longammo > 0:
				Global.longammo -= 1
				Global.abletoclick = false
				$Reload.play()
				yield($Reload,"finished")
				Global.sniperammo = Global.maxsniperammo
	Global.abletoclick = true
	
	if Global.InWater == true:
		$Light2D.energy = 0.35
	else:
		$Light2D.energy = 0.5

func _on_AttackCooldown_timeout():
	able_to_attack = true
	$AttackCooldown.wait_time = 1.00 / Global.attackcooldown
	Global.abletoclick = true

func _on_DashCooldown_timeout():
	able_to_dash = true

func fire():
	var tick = 0
	if Global.weaponselect == 1:
		if Global.pistolammo > 0:
			Global.pistolammo -= 1
			var bullet = bulletscene.instance()
			bullet.rotation_degrees = rotation_degrees
			bullet.position = $Sprite/BackHand/Position2D.global_position
			get_parent().add_child(bullet)
	elif Global.weaponselect == 2:
		if Global.dbshotgunammo > 0:
			Global.dbshotgunammo -= 1
			while tick <= 7:
				var bullet = bulletscene.instance()
				bullet.rotation_degrees = rotation_degrees
				bullet.position = $Sprite/BackHand/Position2D.global_position
				get_parent().add_child(bullet)
				tick += 1
	elif Global.weaponselect == 3:
		if Global.lrshotgunammo > 0:
			Global.lrshotgunammo -= 1
			while tick <= 4:
				var bullet = bulletscene.instance()
				bullet.rotation_degrees = rotation_degrees
				bullet.position = $Sprite/BackHand/Position2D.global_position
				get_parent().add_child(bullet)
				tick += 1
	elif Global.weaponselect == 4:
		if Global.rifleammo > 0:
			Global.rifleammo -= 1
			var bullet = bulletscene.instance()
			bullet.rotation_degrees = rotation_degrees
			bullet.position = $Sprite/BackHand/Position2D.global_position
			get_parent().add_child(bullet)
	elif Global.weaponselect == 5:
		if Global.sniperammo > 0:
			Global.sniperammo -= 1
			var bullet = bulletscene.instance()
			bullet.rotation_degrees = rotation_degrees
			bullet.position = $Sprite/BackHand/Position2D.global_position
			get_parent().add_child(bullet)
	tick = 0
	

func _on_DownslashHitbox_body_entered(body):
	if body.is_in_group("Enemy"):
		motion.y = -RECOIL


func _on_MurasamaDownSlash_body_entered(body):
	if body.is_in_group("Enemy"):
		motion.y = -RECOIL
