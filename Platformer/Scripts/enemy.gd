extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var run_speed = 200
export (int) var gravity = 1200
var velocity = Vector2()
var right
var left
# Called when the node enters the scene tree for the first time.
func _ready():
	$Anim.play("idle_anim")
	_check_velocity_update()
	if right:
		velocity.x += run_speed
		pass
	if left:
		$Sprite.set_flip_h(true)
		velocity.x -= run_speed
		pass
	pass # Replace with function body.

func _check_velocity_update():
	velocity.x = 0
	if position.x > 1024/2:
		left = true
		right = false
	elif position.x < 1024/2:
		right = true
		left = false
	pass

func _physics_process(delta):
	if right:
		if position.x > 1030:
			queue_free()

	elif left:
		if position.x < -20:
			queue_free()

	velocity.y += gravity * delta
	move_and_slide(velocity,Vector2(0,-1))
	pass


func _spawn_self(pos):
	position = pos