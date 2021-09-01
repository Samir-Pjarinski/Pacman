extends KinematicBody2D


export(float) var speed = 5
var path : Array = []
onready var level_navigation = get_parent().get_node("Navigation2D")
onready var player = get_parent().get_node("Pacman")


var velocity = Vector2.ZERO


func _physics_process(delta):
	generate_path()
	navigate()
	position = position.linear_interpolate(position + velocity*20, speed*delta)


func generate_path():
	path = level_navigation.get_simple_path(global_position, player.global_position)
	
func navigate():
	if (path.size() > 0):
		var dir = global_position.direction_to(path[1]);
		var dir_simple = Vector2.ZERO
		
		if abs(dir.x) > abs(dir.y):
			if (dir.x < 0): 
				dir_simple.x = -1
			else:
				dir_simple.x = 1
		else:
			if (dir.y < 0): 
				dir_simple.y = -1
			else:
				dir_simple.y = 1        
		velocity = dir_simple
		
		if global_position == path[0]:
			path.pop_front()
