extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pause_input 	: bool = false
var text_str 		: String = ""
var current_char 	: int = 0
var max_char 		: int = 0
var pressed_key 	: String = ""
var red				: Color = Color(1,0,0)
var blue			: Color = Color(0,0,1)
var timer			: float = 0
var white_list_scancode = ["Comma",
						   "Period",
						   "Space",
						   "Exclam",
						   "Question"
						]
var text_list		= ["Nunc id lacus orci. Nulla facilisi. Nulla sapien nisi, ullamcorper ut iaculis sed, convallis quis tellus. Integer eu laoreet ipsum. Morbi at metus sit amet sapien vehicula luctus a id dui. Donec fringilla erat elit, non tincidunt sem sodales vel. In imperdiet congue eros vel aliquam. Donec at libero eget nibh tincidunt blandit. Sed elementum ultricies blandit. In quis eleifend ligula. Aliquam ultrices enim sit amet semper venenatis. Nam quis facilisis erat. Ut dictum ante imperdiet dapibus consequat. Morbi vitae feugiat nunc, nec bibendum velit. Curabitur vitae mattis ipsum, vel dignissim ligula. Mauris scelerisque dignissim augue, suscipit dapibus dolor ullamcorper quis.",
					   "Aenean sit amet tellus quis arcu pretium varius eu cursus lectus. Aenean semper condimentum tincidunt. Nulla congue hendrerit lacus. Quisque ac erat urna. In libero ipsum, bibendum vel nunc in, pellentesque ultricies est. Aliquam gravida ligula et sem vulputate fermentum. Nulla bibendum porttitor dolor, et tristique turpis fringilla non. Fusce accumsan ultricies eros, ut fringilla ex porta non. Nam eleifend nunc ligula, at tristique purus pellentesque nec. Maecenas a porta ex, vitae mattis tellus. Ut condimentum at diam ac interdum.",
					   "Interdum et malesuada fames ac ante ipsum primis in faucibus. Suspendisse iaculis, sem a maximus laoreet, neque erat fringilla nibh, in convallis dui nunc in lectus. Maecenas elementum ultrices dui et lobortis. Mauris in tortor vel leo vehicula mattis. Duis pulvinar risus in arcu auctor, quis luctus sem consectetur. Pellentesque rutrum turpis a tincidunt tempor. Nunc interdum leo eros, sit amet fringilla ipsum hendrerit sit amet. Proin sagittis in dolor a varius. Mauris maximus dolor ultricies sagittis eleifend. Vivamus posuere nibh sed ante fermentum, molestie viverra enim vestibulum. Aliquam tempus elit sit amet nulla sollicitudin fermentum. Maecenas blandit mi id turpis consequat porttitor."
					]
# Called when the node enters the scene tree for the first time.
func _ready():
	_instance_init()

func _instance_init():
	text_str = $Text.text
	print(text_str)
	max_char = text_str.length()
	$Text.clear()
	$Text.push_align(RichTextLabel.ALIGN_CENTER)
	$Text.push_color(Color(1,0,0))
	$Text.add_text(text_str)
	$MsTimer.start()
	pass # Replace with function body.

func _update_color():
	var temp_str = text_str.substr(0,current_char + 1)
	$Text.clear()
	$Text.push_align(RichTextLabel.ALIGN_CENTER)
	$Text.push_color(blue)
	$Text.add_text(temp_str)
	temp_str = text_str.substr(current_char + 1,max_char)
	$Text.push_color(red)
	$Text.add_text(temp_str)
	pass

func _input(event):
	if !pause_input:
		if event is InputEventKey:
			if event.pressed:
				_event_filter(event)
				_check_pressed_key(pressed_key)
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _check_pressed_key(pressed_key):
	if text_str[current_char].match(pressed_key):
		_update_color()
		print("correct")
		current_char += 1
		_check_current_char(current_char)
	else:
		print("wrong")

func _check_current_char(current_char):
	if current_char >= max_char:
		print("game ended")
		$MsTimer.stop()
		get_tree().paused = true
		return
	pass

func _event_filter(event):
	var scancode = OS.get_scancode_string(event.scancode)
	print(scancode)
	var scan_code_valid = true
	for sc in white_list_scancode:
		if scancode == sc:
			scan_code_valid = true
		
	if not scan_code_valid and scancode.length() > 1:
		return
	else:
		$InputDelay.start()
		pause_input = true
		pressed_key = char(event.unicode)
		if scan_code_valid:
			_parse_scancode(scancode)
		print(pressed_key)
	
	pass


func _parse_scancode(scancode):
	if scancode == "Space":
		pressed_key = " "
	elif scancode == "Comma":
		pressed_key = ","
	elif scancode == "Period":
		pressed_key = "."
	elif scancode == "Exclam":
		pressed_key = "!"
	elif scancode == "Question":
		pressed_key = "?"
	pass


func _update_timer(ms):
	$TimerLabel.text = str(ms)
	pass


func _on_InputDelay_timeout():
	pause_input = false
	pass # Replace with function body.


func _on_MsTimer_timeout():
	timer += 0.01
	_update_timer(timer)
	pass # Replace with function body.
