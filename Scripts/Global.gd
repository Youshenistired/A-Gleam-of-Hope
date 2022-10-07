extends Node

export var money = 69

export var InWater = false
export var health = 100
export var damage = 5
export var attackcooldown = 0
export var emo = false
export var waterstone = true
export var earthstone = true
export var firestone = true
export var shield = false
export var shieldhealth = 0

export var level2 = false
export var level3 = false
export var level4 = false
export var level5 = false

export var buildablestate = ""
export var onladder = false

export var abletoclick = true
export var dashcooldown = 1
export var volume = 50

var doublejump = true
var dash = true
var gun = false
var camera = null
var spawnpointx
var spawnpointy

var weaponselect = 0
var pistol = true
var dbshotgun = true
var lrshotgun = true
var rifle = true
var sniper = true
var murasama = false

export var shell = 69420
export var ammo = 69420
export var longammo = 69420

export var currentammo = 0
export var currentmaxammo = 0

export var pistolammo = 20
export var dbshotgunammo = 2
export var lrshotgunammo = 5
export var rifleammo = 60
export var sniperammo = 5

export var maxpistolammo = 20
export var maxdbshotgunammo = 2
export var maxlrshotgunammo = 5
export var maxrifleammo = 60
export var maxsniperammo = 5

export var VMHealth = 0
export var VMShield = 0
export var VMSpeedBoost = 0
export var VMShell = 0
export var VMAmmo = 0
export var VMLongAmmo = 0


func _physics_process(delta):
	if Global.health > 100:
		Global.health = 100
	elif Global.health < 0:
		Global.health = 0
	if Global.shieldhealth < 0:
		Global.shieldhealth = 0
	elif Global.shieldhealth > 50:
		Global.shieldhealth = 50
	if Global.weaponselect == 0:
		damage = 5
		attackcooldown = 3
		currentammo = 0
		currentmaxammo = 0
	elif Global.weaponselect == 1:
		damage = 5
		attackcooldown = 4
		currentammo = pistolammo
		currentmaxammo = maxpistolammo
	elif Global.weaponselect == 2:
		damage = 8
		attackcooldown = 1
		currentammo = dbshotgunammo
		currentmaxammo = maxdbshotgunammo
	elif Global.weaponselect == 3:
		damage = 10
		attackcooldown = 1
		currentammo = lrshotgunammo
		currentmaxammo = maxlrshotgunammo
	elif Global.weaponselect == 4:
		damage = 5
		attackcooldown = 7
		currentammo = rifleammo
		currentmaxammo = maxrifleammo
	elif Global.weaponselect == 5:
		damage = 20
		attackcooldown = 0.5
		currentammo = sniperammo
		currentmaxammo = maxsniperammo
	elif Global.weaponselect == 6:
		damage = 8
		attackcooldown = 4
		currentammo = 0
		currentmaxammo = 0
	
	if shieldhealth <= 0:
		shield = false

onready var settingsmenu = load("res://Scene/MainMenu.tscn")
var filepath = "res://keybinds.ini"
var configfile

var keybinds = {}

func _ready():
	configfile = ConfigFile.new()
	if configfile.load(filepath) == OK:
		for key in configfile.get_section_keys("keybinds"):
			var key_value = configfile.get_value("keybinds", key)
			
			if str(key_value) != "":
				keybinds[key] = key_value
			else:
				keybinds[key] = null
	else:
		print("CONFIG FILE NOT FOUND")
		get_tree().quit()
	
	set_game_binds()

func set_game_binds():
	for key in keybinds.keys():
		var value = keybinds[key]
		
		var actionlist = InputMap.get_action_list(key)
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])
		
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)

func write_config():
	for key in keybinds.keys():
		var key_value = keybinds[key]
		if key_value != null:
			configfile.set_value("keybinds", key, key_value)
		else:
			configfile.set_value("keybinds", key, "")
	configfile.save(filepath)


