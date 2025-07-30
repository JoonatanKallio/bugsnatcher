extends CharacterBody2D
@onready var death = $AudioStreamPlayer

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Bullet:
		hide() 
		set_physics_process(false)
		set_process(false)
		$CollisionShape2D.disabled = true 
		death.play()
		await death.finished
		queue_free()
