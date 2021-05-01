extends KinematicBody2D

export(float) var max_speed = 800

onready var FireballScene = preload("res://fireball/Fireball.tscn")

onready var FireballSpawnPosition = $FireballSpawnPosition

export(float) var fire_cooldown = 1.0 / 8.0
var current_fire_cooldown = 0

var input_target_velocity = Vector2.ZERO

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
	input_target_velocity = input_vector * max_speed

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
		
func target_velocity():
	return input_target_velocity

