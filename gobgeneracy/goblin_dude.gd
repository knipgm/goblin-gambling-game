extends CharacterBody2D

@export var speed = 400
@onready var _animation_player = $AnimationPlayer

var animation_action := "idle"
var last_direction := "down"
var animation_to_play := "idle-down"

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
	print(velocity)
	print(input_direction)
	
	_update_animation_action(input_direction)

func _physics_process(delta): #btw we never use delta..... maybe multiply
	get_input()
	move_and_slide()
	
	print(animation_action)
	_animation_player.play(_build_animation_text(animation_action, last_direction))

func _update_animation_action(input_direction):
	var new_direction:=""

	new_direction = _get_direction_text(input_direction.x, input_direction.y)
	
	var isMoving := false
	isMoving = (abs(velocity.x) >= .5 or abs(velocity.y) >= .5)
	

	last_direction = new_direction if isMoving else last_direction
	animation_action = _get_action_text(input_direction)
	
	
	
func _get_axis_horiz_text(x):
	if(abs(x)<.5):
		return ""
	return "right" if x > 0 else "left"
	
func _get_axis_vert_text(y):
	if(abs(y)<.5):
		return ""
	return "down" if y > 0 else "up"
	
func _get_action_text(input_direction):
	return "walk" if (abs(input_direction.x) > 0 or abs(input_direction.y) > 0) else "idle"
	
func _get_direction_text(x, y):
	if(abs(x)>abs(y)):
		return _get_axis_horiz_text(x)
	return _get_axis_vert_text(y)
	
func _build_animation_text(action_text, direction_text):
	print(action_text)
	print(direction_text)
	return action_text + "-" + direction_text
