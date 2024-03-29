extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
## MOVEMENT CONTROL
var facing_left = false
var facing_right = false
var is_jumping = false
var is_attacking = false

## PUBLIC VARIABLES
export (int) var GRAVITY_SPEED = 3200
export (int) var RUN_SPEED = 200
export (int) var JUMP_SPEED = 600
## PLAYER VELOCITY
var vel = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	vel.x = 0
	facing_left = false
	facing_right = false
	
	if Input.is_action_pressed("ui_left"):
		if !is_jumping:
			$PlayerAnim.play("run")
		$PlayerAnim.flip_h = true
		facing_left = true
		vel.x -= RUN_SPEED
		pass
		
	if Input.is_action_pressed("ui_right"):
		if !is_jumping:
			$PlayerAnim.play("run")
		$PlayerAnim.flip_h = false
		facing_right = true
		vel.x += RUN_SPEED
	pass
	
	if Input.is_action_pressed("ui_up") && !is_jumping:
		if is_on_floor():
			$PlayerAnim.play("jump")
			is_jumping = true
			vel.y = -JUMP_SPEED
		pass
	
	if Input.is_action_pressed("attack") && !is_attacking:
		if is_on_floor():
			is_attacking = true
			$PlayerAnim.play("idle_attack")
			$Attack1.start()
	
	if _is_idle():
		$PlayerAnim.play("idle")

func _physics_process(delta):
	vel.y += GRAVITY_SPEED * delta
	if is_at_edge() && is_on_floor():
		vel.x = 0
	vel = move_and_slide(vel,Vector2(0,-1))
	if is_on_floor() && !is_attacking:
		is_jumping = false
		if facing_left || facing_right:
			$PlayerAnim.play("run")
		else:
			$PlayerAnim.play("idle")
	pass
	
func is_at_edge():
	var gap = 5
	var hold = 16 + 5
	if vel.x < 0 and position.x <= hold:
		# Left edge
		return true
	if vel.x > 0 and position.x >= 1024 - hold:
		# Right edge
		return true
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _is_idle():
	if !facing_left && !facing_right && !is_jumping && !is_attacking:
		return true
	pass

func _on_Attack1_timeout():
	if Input.is_action_pressed("attack") && is_on_floor():
		$PlayerAnim.play("idle_attack_2")
		$Attack2.start()
	else:
		is_attacking = false
	pass # Replace with function body.


func _on_Attack2_timeout():
	if Input.is_action_pressed("attack") && is_on_floor():
		$PlayerAnim.play("idle_attack_3")
		$Attack3.start()
	else:
		is_attacking = false
	pass # Replace with function body.


func _on_Attack3_timeout():
	is_attacking = false
	pass # Replace with function body.
