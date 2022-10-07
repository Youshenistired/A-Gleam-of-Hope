extends ParallaxLayer

export var CLOUD_SPEED = -15

func _physics_process(delta):
	self.motion_offset.x += CLOUD_SPEED * delta
