extends WorldEnvironment

var pause = false
var tick = 0
var spawnpointx
var spawnpointy
var startpointx
var startpointy

func _ready():
	var player = get_node("Player")
	startpointx = player.global_position.x
	startpointy = player.global_position.y
	$EmoTime.visible = false
	$Music.play()
	$UI/AnimationPlayer.play("LoadScene")
	yield($UI/AnimationPlayer,"animation_finished")
	$UI/PauseWindow.visible = true

func _physics_process(delta):
	if Global.health <= 15:
		$GlitchEffect.visible = true
	else:
		$GlitchEffect.visible = false
	if Global.health <= 0 and tick == 0:
		tick = 1
		$UI/PauseWindow.visible = false
		$UI/AnimationPlayer.play("ChangeScene")
		yield($UI/AnimationPlayer,"animation_finished")
		get_tree().change_scene("res://Scene/DeathScreen.tscn")
	if Global.emo == true:
		$EmoTime.visible = true
	elif Global.emo == false:
		$EmoTime.visible = false
	if Input.is_action_just_pressed("Pause"):
		pause = !pause
		if pause == true:
			$UI/AnimationPlayer.play("Pause")
			yield($UI/AnimationPlayer,"animation_finished")
		elif pause == false:
			$UI/AnimationPlayer.play("Unpause")
			yield($UI/AnimationPlayer,"animation_finished")
	
	if Input.is_action_just_pressed("Interact"):
		if Global.buildablestate == "ExitDoor": 
			if self.name == "level_1":
				Global.level2 = true
			if self.name == "level_2":
				Global.level3 = true
			if self.name == "level_3":
				Global.level4 = true
			if self.name == "level_4":
				Global.level5 = true
			$ExitDoorsfx.play()
			$UI/AnimationPlayer.play("ChangeScene")
			yield($UI/AnimationPlayer,"animation_finished")
			get_tree().change_scene("res://Scene/LevelCompleteScreen.tscn")

func _on_HomeButton_pressed():
	$UI/PauseWindow.visible = false
	$UI/AnimationPlayer.play("ChangeScene")
	yield($UI/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/MainMenu.tscn")

func _on_SettingsButton_pressed():
	$UI/PauseWindow.visible = false
	$UI/AnimationPlayer.play("ChangeScene")
	yield($UI/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/SettingsMenu.tscn")


func _on_DeathArea_body_entered(body):
	Global.health -= 10
	var player = get_node("Player")
	if Global.spawnpointx != null and Global.spawnpointy != null:
		player.global_position.x = Global.spawnpointx
		player.global_position.y = Global.spawnpointy
	else:
		player.global_position.x = startpointx
		player.global_position.y = startpointy 
