extends Area2D

@export var target_path: NodePath
@export var exit_offset := Vector2(0, -48)

@onready var glow: Polygon2D = $Glow

func _process(delta: float) -> void:
	glow.rotation += delta * 1.4
	glow.modulate.a = 0.65 + sin(Time.get_ticks_msec() * 0.006) * 0.2

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") or body.has_meta("portal_lock"):
		return
	var target := get_node_or_null(target_path) as Node2D
	if target == null:
		push_warning("Portal target is not configured: %s" % target_path)
		return
	body.set_meta("portal_lock", true)
	body.global_position = target.global_position + exit_offset
	body.velocity.y = -180
	AudioManager.level_complete_sfx.play()
	await get_tree().create_timer(0.45).timeout
	if is_instance_valid(body):
		body.remove_meta("portal_lock")
