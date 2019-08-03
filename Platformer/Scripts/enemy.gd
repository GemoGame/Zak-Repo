extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
## EXPORT VARIABLE THAT COULD BE EDITED IN THE INSPECTOR
## PROPERTY OF MOVEMENT AND OBJECT GROUPING
export (int) var run_speed = 200
export (int) var gravity = 1800
export (String) var tag = ""
export (int) var up_speed = -600

## MAIN PROPERTY OF CONTROLS OF THE ENEMY 
var velocity = Vector2()
var right
var left
var collosion = Vector2()

# Called when the node enters the scene tree for the first time.
#SET THE DIRECTION OF MOVEMENT FOR THE FIRST TIME AFTER SPAWN
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

# CHECKING POSITION UPDATE TO DECIDE THE DIRECTION OF THE MOVEMENT
func _check_velocity_update():
	velocity.x = 0
	if position.x > 1024/2:
		left = true
		right = false
	elif position.x < 1024/2:
		right = true
		left = false
	pass

# Checking is done by frame
# CHECKING POSITION OF THE OBJECT. IN ORDER TO MOVE,
# AND TO DESTROY THE OBJECT IF THE OBJECT IS OUT OF SCREEN
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
			
	collosion = move_and_slide(velocity, Vector2(-1,0))
#	_check_collosion()
	pass

# DISABLE COLLOSION OF THE OBJECT
func _disable_collosion(cond):
	$CollisionShape2D.disabled = cond
	pass

# NEEDS DEBUG
func _check_collosion():
	if collosion:
		if collosion.collider != StaticBody2D:
			if collosion.collider.tag != "player":
				add_collision_exception_with(collosion.collider)
	pass

# STOP ANY ANIMATION OF THE OBJECT AND "REVERVE THE GRAVITY FOR A WHILE
func _death_state():
	$Anim.stop()
	_set_gravity(false)
	velocity.x = 0
	$RevGravity.start()
	pass
# SET THE GRAVITY
func _set_gravity(cond):
	if cond:
		gravity = 1800
	else:
		gravity = 0

func _spawn_self(pos):
	position = pos
	
# REVERSE THE GRAVITY
func _on_RevGravity_timeout():
	velocity.y += -1*up_speed*4/5
	_set_gravity(true)
	pass # Replace with function body.
