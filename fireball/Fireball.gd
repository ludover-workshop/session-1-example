extends Node2D

export(float) var speed = 900

export(float) var time_to_live = 3

export(float) var damage = 10

func _physics_process(delta):
	var velocity = Vector2(speed, 0).rotated(self.rotation)
	
	position += velocity * delta
	
	time_to_live -= delta
	
	if time_to_live <= 0:
		queue_free()


func _on_Area2D_body_entered(demon):
	demon.receive_damage(damage)
	queue_free()
