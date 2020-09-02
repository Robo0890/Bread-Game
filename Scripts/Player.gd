extends KinematicBody2D


var velocity = Vector2()
export var gravity = 56
export var jump_power = 30
export var maxfallspeed = 200
export var speed = 10
export var maxspeed = 10
var movement = Vector2()

func _physics_process(delta):
	
	
	if Input.is_action_pressed("PlayerLeft"):
		
		if Input.is_action_pressed("PlayerRight"):
			movement.x = 0
		else:
			movement.x = -speed
			
	if Input.is_action_just_released("PlayerLeft") or Input.is_action_just_released("PlayerRight"):
		movement.x = lerp(movement.x, 0, .5)
		
	if Input.is_action_pressed("PlayerRight"):
		if Input.is_action_pressed("PlayerLeft"):
			movement.x = 0
		else:
			movement.x = speed
	
	
	if Input.is_action_pressed("PlayerJump") and is_on_floor():
		velocity.y += -jump_power
	if velocity.y < maxfallspeed:
		velocity.y += gravity
	else:
		velocity.y = maxfallspeed
	
	move_and_slide(velocity, Vector2.UP)
	move_and_collide(movement)


func _ready():
	pass
