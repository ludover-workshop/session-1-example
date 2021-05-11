extends Projectile

onready var ExplosionScene = preload("res://meteor/Explosion.tscn")

func on_hit(body):
	var explosion = ExplosionScene.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
