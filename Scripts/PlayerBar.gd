extends Node2D

func _ready():
	if Global.shield == true:
		$AnimationPlayer.play("IdleShield")
	elif Global.shield == false:
		$AnimationPlayer.play("Idle Playerbar")

func _physics_process(delta):
	$WeaponSelect.frame = Global.weaponselect
	$ShieldHealth.frame = Global.shieldhealth
	if Global.shield == true:
		$ShieldHealth.visible = true
		$AnimationPlayer.play("IdleShield")
	elif Global.shield == false:
		$ShieldHealth.visible = false
		$AnimationPlayer.play("Idle Playerbar")
	
	if $AnimationPlayer.is_playing() == false:
		if Global.shield == true:
			$AnimationPlayer.play("IdleShield")
		elif Global.shield == false:
			$AnimationPlayer.play("Idle Playerbar")
		pass
	
	if Global.health > 0:
		$Health.frame = Global.health - 1
	else:
		$Health.frame = 0
	
	if Global.health <= 15:
		if $HeartBeatsfx.playing == false:
			$HeartBeatsfx.play()
	else:
		$HeartBeatsfx.playing = false
	
	if Input.is_action_just_pressed("Switch Weapon"):
		Global.weaponselect += 1
		if Global.weaponselect > 6:
			Global.weaponselect = 0
		
		if Global.pistol == false and Global.weaponselect == 1:
			Global.weaponselect += 1
		if Global.dbshotgun == false and Global.weaponselect == 2:
			Global.weaponselect += 1
		if Global.lrshotgun == false and Global.weaponselect == 3:
			Global.weaponselect += 1
		if Global.rifle == false and Global.weaponselect == 4:
			Global.weaponselect += 1
		if Global.sniper == false and Global.weaponselect == 5:
			Global.weaponselect += 1
		if Global.murasama == false and Global.weaponselect == 6:
			Global.weaponselect = 0
	
	$Ammo.text = str(Global.currentammo)
	$MaxAmmo.text = str(Global.currentmaxammo)
	$ShellIcon.text = str(Global.shell)
	$AmmoIcon.text = str(Global.ammo)
	$LongAmmoIcon.text = str(Global.longammo)
