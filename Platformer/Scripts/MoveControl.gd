extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var start = Vector2()
var last = Vector2()
signal move_left
signal move_right
signal jump
signal idle
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	_drag_control(event)
	#_jump_control(event)
	pass

func _drag_control(event):
	if event is InputEventMouseButton:
		if event.pressed && event.button_index > 1:
			start = event.position
		elif !event.pressed:
			start = Vector2(576,0)
			print("player is now idle")
			emit_signal("idle")
	if event is InputEventScreenDrag:
			last = event.position
			print("screen dragging")
			if start < last:
				print("player is moving right")
				emit_signal("move_right")
			else:
				print("player is moving left")
				emit_signal("move_left")
	pass
	
func _jump_control(event):
	if event is InputEventMouseButton:
		if event.pressed && event.position.x > 1024/2:
			print("player is jumping")
			emit_signal("jump")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass