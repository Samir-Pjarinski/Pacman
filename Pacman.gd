extends AnimatedSprite

export var speed = 5
var dir = Vector2.ZERO
var prev_dir = Vector2.ZERO
onready var ray = $RayCast2D
onready var walls = get_parent().get_node("Navigation2D/Map")

func _ready():
	play("walk")

var score = 0

func _process(delta):
	if global_position.x < 250:
		global_position.x = 850
	elif global_position.x > 850:
		global_position.x = 250
	
	dir = Vector2.ZERO
	if Input.is_action_just_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		dir.y = -1
		rotation_degrees = 270
	elif Input.is_action_just_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		dir.y = 1
		rotation_degrees = 90
	elif Input.is_action_just_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		dir.x = 1
		rotation_degrees = 0
	elif Input.is_action_just_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		dir.x = -1
		rotation_degrees = 180
	
	if walls.has_wall(global_position + dir * 16) != -1  and walls.has_wall(global_position + dir * 16) <= 43:
		dir = Vector2.ZERO
	
	if dir.length_squared() != 0:
		prev_dir = dir
	else:
		dir = prev_dir
	
	if walls.has_wall(global_position + dir * 16) != -1  and walls.has_wall(global_position + dir * 16) <= 43:
		dir = Vector2.ZERO
	
	if walls.eat(position):
		score += 1
		$CanvasLayer/Label.text = "SCORE: " + str(score)
	
	if dir.length_squared() == 0:
		frame = 0
		stop()
	else:
		play("walk")
	
	position = position.linear_interpolate(position + dir*20, speed*delta)
