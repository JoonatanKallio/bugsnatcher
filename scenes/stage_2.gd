extends Node2D



func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group('player'):
		get_tree().change_scene_to_file("res://scenes/world_2.tscn")
