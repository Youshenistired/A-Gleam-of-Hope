extends Node2D

const dash_delay = 0.4

onready var timer = $Timer
onready var ghost_timer = $GhostTimer

var can_dash = true
var sprite
var ghost_scene = preload("res://Scene/DashGhost.tscn")


func start_dash(sprite, duration):
	self.sprite = sprite
	timer.wait_time = duration
	timer.start()
	
	ghost_timer.start()
	instance_ghost()

func instance_ghost():
	var ghost: Sprite = ghost_scene.instance()
	get_parent().get_parent().add_child(ghost)

	ghost.position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h

func end_dash():
	ghost_timer.stop()
	
	can_dash = false
	yield(get_tree().create_timer(dash_delay), 'timeout')
	can_dash = true

func is_dashing():
	return !timer.is_stopped()

func _on_GhostTimer_timeout():
	instance_ghost()

func _on_Timer_timeout():
	end_dash()
