extends Area2D
class_name Bullet
var direction = 1;

func _ready():
	position = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position.x += 20 * direction


func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "TileMap":
		queue_free()
