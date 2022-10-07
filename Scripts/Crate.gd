extends KinematicBody2D

onready var coin = preload("res://Scene/Coin.tscn")
onready var itemobject = preload("res://Scene/Item.tscn")
var itemchance
var item = null
var coinamount
var addcoin = false
var additem = false

func _ready():
	coinamount = rand_range(1, 15)
	itemchance = rand_range(1, 100)
	if itemchance > 60:
		item = rand_range(1, 6)

func _physics_process(delta):
	if addcoin == true:
		if coinamount > 0:
			var coins = coin.instance()
			coins.position = self.global_position
			var random = rand_range(-15, 15)
			coins.position.x += random
			get_tree().get_root().add_child(coins)
			coinamount -= 1
	
	if additem == true:
		if item != null:
			var object = itemobject.instance()
			object.itemtype = item
			object.global_position = self.global_position
			get_parent().add_child(object)

func _on_Area2D_area_entered(area):
	if area.is_in_group("Attack"):
		additem = true
		addcoin = true
		
		$AudioStreamPlayer.play()
		yield($AudioStreamPlayer,"finished")
		queue_free()
	
