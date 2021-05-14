extends Camera2D
class_name CameraShaker

var duration = 0.5
var strength = 15
var frequency = 5

var remainingShakeDuration = 0

var phase = Vector2.ZERO

func shake(strength = 15, duration = 0.7, frequency = 5):
	phase = Vector2(rand_range(0, TAU), rand_range(0, TAU))
	self.strength = strength
	self.duration = duration
	self.frequency = frequency
	
	remainingShakeDuration = duration

func _physics_process(delta):
	if remainingShakeDuration > 0:
		var elapsed = duration - remainingShakeDuration
		
		offset.x = strength * sin(elapsed * TAU * frequency + phase.x) * (remainingShakeDuration * remainingShakeDuration) / duration
		offset.y = strength * sin(elapsed * TAU * frequency + phase.y) * (remainingShakeDuration * remainingShakeDuration) / duration
		
		remainingShakeDuration -= delta
	else:
		offset = Vector2.ZERO
