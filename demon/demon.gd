extends KinematicBody2D

var max_speed = 600

var rotation_speed = PI * 0.4

onready var animationPlayerDamage = $AnimationPlayerDamage

onready var mage = get_tree().current_scene.find_node("MageBody")

onready var animationPlayerWalk = $AnimationPlayerWalk
onready var targetVelocityBehaviour = $TargetVelocityBehaviour

var attacking = false
var attack_cooled_down = true

export(float) var damage = 10
export(float) var knockback_speed = 500

func front():
	return Vector2.RIGHT.rotated(self.rotation)

func angle_front_to_position(target_position):
	var target_front = target_position - self.position
	return front().angle_to(target_front)

func rotate_towards(target_position, delta):
	var to_target = angle_front_to_position(target_position)
	var max_rotation = rotation_speed * delta
	
	if(abs(to_target) < PI / 3):
		# en frente
		rotation_speed = PI * 0.4
	else:
		rotation_speed = PI 
	
	if(max_rotation > abs(to_target)):
		rotate(to_target)
	else:
		rotate(sign(to_target) * max_rotation)

func _physics_process(delta):
	if is_instance_valid(mage):
		rotate_towards(mage.position, delta)
	
	animationPlayerWalk.playback_speed = targetVelocityBehaviour.velocity.length() / max_speed

func _process(delta):	
	if attack_cooled_down && attacking:
		attack()

func attack():
	for body in $AttackArea.get_overlapping_bodies():
		DamageableBehaviour.do_damage(body, damage, self.position, knockback_speed)
			
	attack_cooled_down = false
	$AttackCooldownTimer.start()
		
func target_velocity():
	return front() * max_speed

func _on_AttackCooldownTimer_timeout():
	attack_cooled_down = true


func _on_AttackArea_body_entered(body):
	attacking = true


func _on_AttackArea_body_exited(body):
	if $AttackArea.get_overlapping_bodies().empty():
		attacking = false
