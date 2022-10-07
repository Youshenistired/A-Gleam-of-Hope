extends Area2D

func _ready():
	$AnimationPlayer.play("Idle")
	if self.name == "Pistol":
		$Sprite.frame = 1
	elif self.name == "dbshotgun":
		$Sprite.frame = 2
	elif self.name == "lrshotgun":
		$Sprite.frame = 3
	elif self.name == "Rifle":
		$Sprite.frame = 4
	elif self.name == "Sniper":
		$Sprite.frame = 5
	elif self.name == "Murasama":
		$Sprite.frame = 6
	elif self.name == "Dash":
		$Sprite.frame = 7
	elif self.name == "DoubleJump":
		$Sprite.frame = 8

func _on_GunUpgrade_body_entered(body):
	if body.is_in_group("Player"):
		if self.name == "Pistol":
			Global.pistol = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		elif self.name == "dbshotgun":
			Global.dbshotgun = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		elif self.name == "lrshotgun":
			Global.lrshotgun = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		elif self.name == "Rifle":
			Global.rifle = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		elif self.name == "Sniper":
			Global.sniper = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		elif self.name == "Murasama":
			Global.murasama = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		elif self.name == "Dash":
			Global.dash = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		elif self.name == "DoubleJump":
			Global.doublejump = true
			$GetSfx.play()
			$AnimationPlayer.play("Get")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
		
		SaveState.save_game()
