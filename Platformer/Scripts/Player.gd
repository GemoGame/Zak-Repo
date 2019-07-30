extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -800
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false

var right
var left
var jump
var attacking
var idle_cond
var input_delay = false

func get_input():
	velocity.x = 0
#    right = Input.is_action_pressed('ui_right')
#    left = Input.is_action_pressed('ui_left')
    #jump = Input.is_action_just_pressed('ui_select')
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right && !attacking:
		print("move right")
		$Sprite.set_flip_h(false)
		velocity.x += run_speed
	if left && !attacking:
		print("move left")
		$Sprite.set_flip_h(true)
		velocity.x -= run_speed

func _physics_process(delta):
	get_input()
	if !left && !right && !attacking:
		$Anim.play("idle_anim")
		print("idle")
	elif !is_on_floor():
		$Anim.play("on_jump")
	elif attacking:
		$Anim.play("attack_anim")
	else:
		$Anim.play("running_anim")
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
		jump = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	


func _on_Left_button_up():
	left = false
	
	pass # Replace with function body.


func _on_Right_button_up():
	right = false
	pass # Replace with function body.


func _on_Jump_pressed():
	if is_on_floor():
		jump = true
		idle_cond = false
	pass # Replace with function body.


func _on_BounceMain_released():
	right = false
	left = false
	idle_cond = true
	pass # Replace with function body.


func _on_Right_button_down():
	right = true
	left = false
	idle_cond = false
	pass # Replace with function body.


func _on_Left_button_down():
	right = false
	left = true
	idle_cond = false
	pass # Replace with function body.


func _on_BounceMain_jump():
	if is_on_floor():
		$Anim.play("on_jump")
		jump = true
		idle_cond = false
	pass # Replace with function body.


func _on_BounceMain_move_left():
	if !attacking:
		get_tree().get_root().set_disable_input(true)
		$InputDelay.start()
		right = false
		left = true
		idle_cond = false
	pass # Replace with function body.


func _on_BounceMain_move_right():
	if !attacking:
		$InputDelay.start()
		get_tree().get_root().set_disable_input(true)
		right = true
		left = false
		idle_cond = false
	pass # Replace with function body.


func _on_BounceMain_attack():
	if is_on_floor():
		print("attack")
		attacking = true
		$Anim.stop()
		$Anim.play("attack_anim")
		$AttackTimer.start()
	pass # Replace with function body.


func _on_AttackTimer_timeout():
	attacking = false
	pass # Replace with function body.


func _on_InputDelay_timeout():
	if idle_cond:
		right = false
		left = false
	get_tree().get_root().set_disable_input(false)
	pass # Replace with function body.
