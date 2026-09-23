extends AnimatableBody2D

@export var travel := Vector2(220, 0)
@export_range(1.0, 10.0, 0.1) var duration := 3.0

var start_position: Vector2
var elapsed := 0.0

func _ready() -> void:
	start_position = position

func _physics_process(delta: float) -> void:
	elapsed += delta
	var progress := (sin(elapsed * TAU / duration - PI / 2.0) + 1.0) * 0.5
	position = start_position + travel * progress
