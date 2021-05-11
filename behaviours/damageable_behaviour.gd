extends Node2D
class_name DamageableBehaviour

var life = 100

onready var animationPlayerDamage = get_parent().get_node_or_null("AnimationPlayerDamage")
onready var targetVelocityBehaviour = get_parent().get_node_or_null("TargetVelocityBehaviour")

func receive_damage(damage, source_position = null, knockback_speed = null):
	life -= damage
	if life <= 0:
		get_parent().queue_free()
		
	if animationPlayerDamage != null:
		animationPlayerDamage.stop()
		animationPlayerDamage.play("Damage")
	
	if(source_position && knockback_speed && targetVelocityBehaviour):
		targetVelocityBehaviour.apply_knockback(source_position, knockback_speed)

static func do_damage(body, damage, source_position = null, knockback_speed = null):
	var damageableNode = body.get_node_or_null("DamageableBehaviour")
	if damageableNode:
		damageableNode.receive_damage(damage, source_position, knockback_speed)
