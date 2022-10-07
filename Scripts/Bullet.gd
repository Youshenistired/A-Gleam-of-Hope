extends Area2D

const SPEED = 7

var damage
var motion = Vector2(0, 0)
var spread
var direction
var pierce = 3

func _ready():
	if Global.weaponselect == 1:
		spread = rand_range(7, -7)
	elif Global.weaponselect == 2:
		spread = rand_range(20, -20)
	elif Global.weaponselect == 3:
		spread = rand_range(15, -15)
	elif Global.weaponselect == 4:
		spread = rand_range(7, -7)
	elif Global.weaponselect == 5:
		spread = rand_range(2, -2)
	
	var player = get_parent().get_node("Player")
	direction = (get_global_mouse_position() - player.global_position)
	if Global.weaponselect == 1 or Global.weaponselect == 4:
		$Sprite.frame = 0
	elif Global.weaponselect == 2 or Global.weaponselect == 3:
		$Sprite.frame = 1
	elif Global.weaponselect == 5:
		$Sprite.frame = 2
	
	look_at(get_global_mouse_position())

func _physics_process(delta):
	motion.x = (direction.x + spread) * SPEED * delta
	motion.y = (direction.y + spread) * SPEED * delta
	translate(motion)

func _on_Timer_timeout():
	queue_free()

func _on_DeathArea_body_entered(body):
	if Global.weaponselect == 5:
		pierce -= 1
		if pierce == 0:
			$Explode.play()
			Global.camera.shake(50, 0.2)
			queue_free()
	else:
		$Explode.play()
		Global.camera.shake(50, 0.2)
		queue_free()
