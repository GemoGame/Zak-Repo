extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal jump
signal move_left
signal move_right
signal released
signal attack
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventMouseButton && event.position.x < 1024/2:
		if !event.is_pressed():
			emit_signal("released")
			print("clicked")
	if event.is_action_pressed("ui_right"):
		emit_signal("move_right")
		pass
	if event.is_action_released("ui_right"):
		emit_signal("released")
	if event.is_action_pressed("ui_left"):
		emit_signal("move_left")
		pass
	if event.is_action_released("ui_left"):
		emit_signal("released")
	if event.is_action_pressed("ui_accept"):
		emit_signal("jump")
	if event.is_action_pressed("attack"):
		emit_signal("attack")
		pass
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass