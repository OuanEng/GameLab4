extends Area2D

@export var launch_force := 900.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.velocity.y = -launch_force
		AudioManager.jump_sfx.play()
