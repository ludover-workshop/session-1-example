extends TextureRect


func _on_DamageableBehaviour_damaged():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Damage")
