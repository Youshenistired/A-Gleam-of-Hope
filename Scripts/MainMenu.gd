extends Control

var audioScale = 20

func _physics_process(delta):
	Global.volume = $VolumeSlider.value

func _on_PlayButton_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/MainHub.tscn")

func _on_SettingsButton_pressed():
	$ButtonPress.play()
	get_node("SettingsButton").focus_mode = FOCUS_NONE
	$AnimationPlayer.play("EnterSettings")
	yield($AnimationPlayer,"animation_finished")

func _on_BackButton_pressed():
	$ButtonPress.play()
	get_node("BackButton").focus_mode = FOCUS_NONE
	$AnimationPlayer.play("ExitSetttings")
	yield($AnimationPlayer,"animation_finished")

func _on_QuitButton_pressed():
	$ButtonPress.play()
	get_node("QuitButton").focus_mode = FOCUS_NONE
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	get_tree().quit()

onready var buttoncontainer = get_node("VBoxContainer")
onready var buttonscript = load("res://KeyButton.gd")

var keybinds
var buttons = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	$VolumeSlider.value = Global.volume
	$Cursor/Sprite.scale.x = 4
	$Cursor/Sprite.scale.y = 4
	$Music.play()
	$AnimationPlayer.play("LoadScene")
	
	keybinds = Global.keybinds.duplicate()
	for key in keybinds.keys():
		var hbox = HBoxContainer.new()
		var label = Label.new()
		var button = Button.new()
		
		hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		label.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		button.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		
		label.text = key
		
		var button_value = keybinds[key]
		
		if button_value != null:
			button.text = OS.get_scancode_string(button_value)
		else:
			button.text = "Unassigned"
		
		button.set_script(buttonscript)
		button.key = key
		button.value = button_value
		button.menu = self
		button.toggle_mode = true
		button.focus_mode = Control.FOCUS_NONE
		
		hbox.add_child(label)
		hbox.add_child(button)
		buttoncontainer.add_child(hbox)
		
		buttons[key] = button

func change_bind(key, value):
	keybinds[key] = value
	for k in keybinds.keys():
		if k != key and value != null and keybinds[k] == value:
			keybinds[k] = null
			buttons[k].value = null
			buttons[k].text = "Unassigned"


func back():
	$ButtonPress.play()
	$AnimationPlayer.play("ExitControls")
	get_node("back").focus_mode = FOCUS_NONE


func save():
	$ButtonPress.play()
	Global.keybinds = keybinds.duplicate()
	Global.set_game_binds()
	Global.write_config()


func _on_ControlsButton_pressed():
	$ButtonPress.play()
	$AnimationPlayer.play("EnterControls")
	get_node("ControlsButton").focus_mode = FOCUS_NONE

func _on_VolumeSlider_value_changed(value):
	if(value == $VolumeSlider.min_value):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), audioScale * value/100)


func _on_SaveGame_pressed():
	SaveState.save_game()
	$ButtonPress.play()
	yield($ButtonPress,"finished")


func _on_LoadGame_pressed():
	SaveState.load_game()
	$ButtonPress.play()
	yield($ButtonPress,"finished")
