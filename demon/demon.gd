extends KinematicBody2D

var life = 100

onready var animationPlayerDamage = $AnimationPlayerDamage

func receive_damage(damage):
	life -= damage
	animationPlayerDamage.play("Damage")
	print(life)
	if life <= 0:
		queue_free()
