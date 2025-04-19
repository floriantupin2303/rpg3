extends Node
const SAVE_PATH="user://"

signal game_loaded
signal game_saved 

var current_save: Dictionary ={
	scene_path="",
	player={
		hp=1,
		max_hp=1,
		pos_x=0,
		pos_y=0
	},
	items=[],
	persistence=[],
	quests=[]
}

func save_game()-> void:
	update_player_data() 
	update_sceane_path()
	var file:= FileAccess.open(SAVE_PATH+"save.sav",FileAccess.WRITE)
	var save_json =JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()



func load_game()->void:
	var file= FileAccess.open(SAVE_PATH+"save.sav",FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save=save_dict
	##pas finis le load_game



func update_player_data() -> void:
	var p: Player=PlayerManager.player
	current_save.player.hp=p.health
	current_save.player.max_hp=p.max_hp
	current_save.player.pos_x=p.global_position.x
	current_save.player.pos_y=p.global_position.y	

func update_sceane_path() -> void:
	var p: String=""
	for c in get_tree().root.get_children():
		if c.name=="world" or c.name=="dungeon" or c.name=="maison":
			p=c.scene_file_path
		current_save.scene_path=p
