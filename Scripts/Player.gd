extends KinematicBody2D


var velocity = Vector2()
export var gravity = .98
export var jump_power = 30
export var maxfallspeed = 200
export var speed = 10
export var maxspeed = 10


func _physics_process(delta):
	
	
	
	
	move_and_slide(velocity, Vector2.UP)


func _ready():
	pass
