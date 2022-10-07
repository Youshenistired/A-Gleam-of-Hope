extends Node2D

var itemtype = 1
var itemname 

func _ready():
	itemname = self.name.rstrip("0123456789@")
	if itemname == "Shell" or itemname == "@Shell":
		itemtype = 1
	elif itemname == "Ammo" or itemname == "@Ammo":
		itemtype = 2
	elif itemname == "LongAmmo" or itemname == "@LongAmmo":
		itemtype = 3
	elif itemname == "ExtraHealth" or itemname == "@ExtraHealth":
		itemtype = 4
	elif itemname == "Shield" or itemname == "@Shield":
		itemtype = 5
	elif itemname == "SpeedBoost" or itemname == "@SpeedBoost":
		itemtype = 6
	$Sprite.frame = itemtype - 1

func _physics_process(delta):
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if itemtype == 1:
			Global.shell += 5
		elif itemtype == 2:
			Global.ammo += 5
		elif itemtype == 3:
			Global.longammo += 10
		elif itemtype == 4:
			Global.health += 40
		elif itemtype == 5:
			Global.shieldhealth = 49
			Global.shield = true
		elif itemtype == 6:
			Global.dashcooldown = 0.5
		queue_free()
