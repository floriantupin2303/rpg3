extends Node
var change_scene: bool = false
@onready var player: Player = $Player

func _ready() -> void:
	player.cardinal_direction=global.play_load_direction
	pass

func _process(delta: float) -> void:
	if change_scene:
		global.play_load_direction=Vector2.DOWN
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		global.current_world="world"
		global.is_changing_world=true





func _on_exit_body_entered(body: Node2D) -> void:
		if body.has_method("player"):
			change_scene=true


func _on_player_camera_change() -> void:
	global.is_changing_world=false
