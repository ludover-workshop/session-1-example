extends Node2D

export(float) var damage = 50
export(float) var knockback_speed = 1000


func _ready():
	Main.shakeCamera(get_tree(), 30, 1, 5)

func _draw():
	var color = Color.yellow
	color.a = 0.5
	draw_circle(Vector2.ZERO, $Area2D/CollisionShape2D.shape.radius, color)

func _on_ExplosionDuration_timeout():
	queue_free()

func _on_Area2D_body_entered(body):
	DamageableBehaviour.do_damage(body, damage, self.position, knockback_speed)
