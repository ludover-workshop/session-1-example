extends Projectile

export(float) var damage = 10
export(float) var knockback_speed = 70

func on_hit(body):
	DamageableBehaviour.do_damage(body, damage, self.position, knockback_speed)
