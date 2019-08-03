extends Node2D
## SEND SIGNALS TO CONTROL THE PLAYER
signal jump
signal move_left
signal move_right
signal released
signal attack


## PRELOADED ENEMIES SCENES
onready var enemies = [preload("res://Platformer/Scenes/BluePatrol.tscn"),
					   preload("res://Platformer/Scenes/Zombie.tscn"),
					   preload("res://Platformer/Scenes/Demon.tscn")
					]
onready var enemy = preload("res://Platformer/Scenes/BluePatrol.tscn")
var obj

## FIRST ENEMY WILL BE SPAWNED AND SPAWN TIMER GOES START
func _ready():
	_spawn_enemy()
	$SpawnTimer.start()
	pass # Replace with function body.

##ENEMY INSTANCE IS GOING TO BE CREATED AND 
##OBJECT POSITION MUST BE SET BEFORE SPAWNED
func _spawn_enemy():
	var obj = enemy.instance()
	obj._spawn_self(Vector2(900,300))
	add_child(obj) # Object Spawn
	pass

## CHECKING THE INPUT IN ORDER TO SEND SIGNALS TO PLAYER SCENE
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


## DURING TIMEOUT, STORED ENEMIES SCENE ARE RANDOMIZED TO BE CHOSEN AS NEXT SPAWNED ENEMIES. 
## ALSO THE SPAWN PLACE BEING RANDOMIZED. WHETHER BE LEFT OR RIGHT
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
