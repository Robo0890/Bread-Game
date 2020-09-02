extends KinematicBody2D

export var maxspeed = 4
export var jumpPower = 600
const UP = Vector2(0,-1)
export var gravity = 20
export var maxfallspeed = 200
var running = true
var touch = false
onready var global = get_node("/root/Global")
var up = false


var in_play = true
var double_jump = false
var movement = Vector2()
var climb = false
var jump = false
var jumpHold = false
var tutorial_Length = 0
var qjump = false
var reset = false
var speed = maxspeed
var maxacc = 8
onready var music = get_parent().get_child(0)



func Music():
	if in_play:
		music.play()
		yield(get_tree().create_timer(8.73),"timeout")
		Music()


func _ready():
	Music()
	#$Secret/AnimationPlayer.play("Float")
	
	$Camera2D/TouchScreenButton.visible = true
	#$Ui_pop.play()


func _physics_process(delta):
	

		
	
	
	if Input.is_action_pressed("ui_accept"):
		_on_TouchScreenButton_pressed()

	
	if Input.is_action_just_released("ui_accept"):
		_on_TouchScreenButton_released()
	
	if touch:
		pass
		
	
	if $".".position.y > 25:
		$".".position = Vector2(-216,-432)
	
	if is_on_wall():
		double_jump = true
		
	if global.speedrunner:
		if !is_on_floor():
			if speed < maxacc:
				speed += .03
			else : speed = maxacc
		elif !is_on_ceiling():
			speed = lerp(speed,maxspeed,.2)
		
	
	if !climb:
		movement.y += gravity 
	if is_on_ceiling() and jumpHold:
		
		climb = true
		double_jump = false

	else:
		climb = false
	if Input.is_action_just_pressed("ui_cancel"):
		if running:
			running = false
		else:
			running = true
	if is_on_floor():
		double_jump = true
		
		$Sprite/AnimationPlayer.play("Run")
	elif climb:
		$Sprite/AnimationPlayer.play("Climb")
	else:
		$Sprite/AnimationPlayer.play("Jump")
	
	if movement.y > maxfallspeed:
		movement.y = maxfallspeed
	if double_jump or is_on_floor():
		if jump and is_on_floor():
			movement.y += -jumpPower
			jump = false
			
		else:
			if jump and double_jump:
				movement.y += -jumpPower
				double_jump = false
				jump = false
				
	move_and_slide(movement, UP)
	if running:
		move_and_collide(Vector2(speed,0))
		
		


func _on_Area2D_area_entered(area):
	pass




func _on_Win_Zone_area_entered(area):
	in_play = false
	music.stop()
	$Control.visible = true
	$Control/AnimationPlayer.play("Win")
	$"YAY!!".play()
	running = false
	jumpPower = 0
	$Sprite/AnimationPlayer.playback_speed = 0


var oneCheck = false

func _on_TouchScreenButton_pressed():
	if !oneCheck:
		touch = true
		oneCheck = true
		$Timer.start(.09)
		$Hold.start(.3)
		
		jump = true
	


func _on_TouchScreenButton_released():
	touch = false
	oneCheck = false
	jumpHold = false
	jump = false

	

	
		

func _on_Timer_timeout():
	if touch:
		qjump = true
		


func _on_Hold_timeout():
	if touch:
		qjump = false
		jumpHold = true
		jump = true
		double_jump = false
		
			


func _on_Lift_area_entered(area):
	up = true
