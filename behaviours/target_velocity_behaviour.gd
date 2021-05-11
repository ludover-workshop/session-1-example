extends Node2D
class_name TargetVelocityBehaviour

export(float) var acceleration_amount = 500
export(float) var friction = 500

var velocity = Vector2.ZERO

func _ready():
	assert(
		get_parent().has_method("target_velocity") && 
		get_parent().has_method("move_and_slide"), "ERROR: Parent must have methods 'target_velocity' & 'move_and_slide'")

func target_velocity():
	return get_parent().target_velocity()

func _physics_process(delta):
	move_with_target_velocity(target_velocity(), delta)

func move_with_target_velocity(target_velocity, delta):
	var acceleration_to_use = acceleration_amount if target_velocity != Vector2.ZERO else friction
	
	velocity = velocity.move_toward(target_velocity, acceleration_to_use * delta)
	
	get_parent().move_and_slide(velocity)	

func apply_knockback(source, knockback_speed):
	var knockback_direction = (get_parent().position - source).normalized()
	velocity = velocity + knockback_direction * knockback_speed
