extends Node2D
class_name Projectile

export(float) var speed = 900
export(float) var time_to_live = 3

func _physics_process(delta):
	var velocity = Vector2(speed, 0).rotated(self.rotation)
	
	position += velocity * delta
	
	time_to_live -= delta
	
	if time_to_live <= 0:
		queue_free()


func _on_Area2D_body_entered(body):
	on_hit(body)
	queue_free()

func on_hit(body):
	assert(false, "Deberían sobreescribir las subclases")
