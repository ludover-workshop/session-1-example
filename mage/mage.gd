extends KinematicBody2D

export(float) var max_speed = 600
export(float) var acceleration_amount = 2000
export(float) var friction = 1000

var velocity = Vector2.ZERO

onready var FireballScene = preload("res://fireball/Fireball.tscn")

onready var FireballSpawnPosition = $FireballSpawnPosition

export(float) var fire_cooldown = 1.0 / 8.0
var current_fire_cooldown = 0

func move_with_keyboard(delta):
	var input_vector = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_right"):
		input_vector.x = 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x = -1
	if Input.is_action_pressed("ui_up"):
		input_vector.y = -1
	if Input.is_action_pressed("ui_down"):
		input_vector.y = 1
	
	input_vector = input_vector.normalized()
	var input_target_velocity = input_vector * max_speed
	
	var acceleration_to_use = acceleration_amount if input_target_velocity != Vector2.ZERO else friction
	
	velocity = velocity.move_toward(input_target_velocity, acceleration_to_use * delta)
	
	self.move_and_slide(velocity)

func point_to_target(delta):
	var mouse_position = get_viewport().get_mouse_position()
	
	self.look_at(mouse_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.move_with_keyboard(delta)
	self.point_to_target(delta)
	
func _process(delta):
	if Input.is_action_pressed("ui_fire") && current_fire_cooldown <= 0:
		var fireball = FireballScene.instance()
		fireball.position = FireballSpawnPosition.global_position
		fireball.rotation = self.rotation
		get_tree().get_current_scene().add_child(fireball)
		current_fire_cooldown = fire_cooldown
	else:
		current_fire_cooldown = max(current_fire_cooldown - delta, 0)


