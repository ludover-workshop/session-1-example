extends Projectile

export(float) var damage = 10
export(float) var knockback_speed = 70


func on_hit(body):
	DamageableBehaviour.do_damage(body, damage, self.position, knockback_speed)

func remove():
	$Area2D.queue_free()
	$AnimatedSprite.queue_free()
		
	$Particles2D.emitting = false
	
	yield(get_tree().create_timer($Particles2D.lifetime), "timeout")
		
	queue_free()
	
