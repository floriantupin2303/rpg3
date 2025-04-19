extends Node2D
var change_scene: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if change_scene:
		global.play_load_direction=Vector2.LEFT
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		global.current_world="world"
		global.is_changing_world=true

func _on_player_camera_change() -> void:
	global.is_changing_world=false


func _on_exit_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print("test")
		change_scene=true
