extends Node2D
class_name Main


func _ready():
	$MageBody/DamageableBehaviour.connect("damaged", self, "_on_MageDamagedBehaviour_damaged")

func _on_MageDamagedBehaviour_damaged():
	$Camera2D.shake(20, 0.7, 5)

static func shakeCamera(tree, strength = 15, duration = 0.7, frequency = 5):
	var camera = tree.current_scene.get_node("Camera2D")
	
	camera.shake(strength, duration, frequency)
