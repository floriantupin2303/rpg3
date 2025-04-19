extends CanvasLayer

@onready var button_save: Button = $Control/VBoxContainer/Button_save
@onready var button_load: Button = $Control/VBoxContainer/Button_load
@onready var item_descritpion: Label = $item_descritpion


signal shown
signal hidden

var is_pause: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	hide_pause_menu()
	button_save.pressed.connect( _on_save_pressed)
	button_load.pressed.connect( _on_load_pressed)
	pass # Replace with function bo<dy.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("pause"):
		if is_pause==false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused=true
	visible=true
	is_pause=true
	shown.emit()
	

func hide_pause_menu() -> void:
	get_tree().paused=false
	visible=false
	is_pause=false
	hidden.emit()

func _on_save_pressed() -> void:
	if is_pause==false:
		return
	GlobalSaveManager.save_game()
	hide_pause_menu()
	pass

func _on_load_pressed() -> void:
	if is_pause==false:
		return
	GlobalSaveManager.load_game()
	hide_pause_menu()
	pass
	
	
func update_item_description(new_text: String) -> void:
		item_descritpion.text=new_text
