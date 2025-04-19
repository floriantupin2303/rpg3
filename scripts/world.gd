extends Node2D


var change_scene: bool = false
var new_world: String


func _ready() -> void:
	pass
	
	

func _process(delta: float) -> void:
	
	if change_scene:
		if new_world=="maison":
			global.play_load_direction=Vector2.UP
		
		global.current_world=new_world
		global.is_changing_world=true
		get_tree().change_scene_to_file("res://scenes/"+new_world+".tscn")


func _on_enter_house_body_entered(body: Node2D) -> void:
	
	if body.has_method("player"):
		change_scene=true
		new_world="maison"


func _on_player_camera_change() -> void:
	global.is_changing_world=false


func _on_enter_dungeao_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		change_scene=true
		new_world="dungeon"
