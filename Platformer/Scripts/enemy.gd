extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var run_speed = 200
export (int) var gravity = 1800
var up_speed = -600
var velocity = Vector2()
var right
var left
# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 460
	$Anim.play("run_anim")
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
			
	if position.y > 576:
		queue_free()
	
	velocity.y += gravity * delta
	
	if gravity == 0:
		velocity.y = up_speed
			
	move_and_slide(velocity,Vector2(0,-1))
	pass

func _disable_collosion(cond):
	$CollisionShape2D.disabled = cond
	pass
	

func _death_state():
	$Anim.stop()
	_set_gravity(false)
	velocity.x = 0
	$RevGravity.start()
	pass

func _set_gravity(cond):
	if cond:
		gravity = 400
	else:
		gravity = 0

func _spawn_self(pos):
	position = pos

func _on_RevGravity_timeout():
	velocity.y += -1*up_speed*4/5
	_set_gravity(true)
	pass # Replace with function body.
