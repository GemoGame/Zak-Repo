extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal jump
signal move_left
signal move_right
signal released
signal attack
onready var enemies = [preload("res://Platformer/Scenes/BluePatrol.tscn"),
					   preload("res://Platformer/Scenes/Zombie.tscn"),
					   preload("res://Platformer/Scenes/Demon.tscn")
					]
onready var enemy = preload("res://Platformer/Scenes/BluePatrol.tscn")
var obj
# Called when the node enters the scene tree for the first time.
func _ready():
	_spawn_enemy()
	$SpawnTimer.start()
	pass # Replace with function body.


func _spawn_enemy():
	var obj = enemy.instance()
	obj._spawn_self(Vector2(900,300))
	add_child(obj)
	pass

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


func _on_SpawnTimer_timeout():
	var id = int(rand_range(0,3))
	obj = enemies[id].instance()
	var rand_number = int(rand_range(0,101))
	if rand_number > 50:
		obj._spawn_self(Vector2(1200,300))
	else:
		obj._spawn_self(Vector2(-200,300))
	add_child(obj)
	pass # Replace with function body.


func _on_Player_game_over():
	pass # Replace with function body.
