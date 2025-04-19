extends Node
const PLAYER = preload("res://scenes/player.tscn")
const INVENTORY_DATA=preload("res://GUI/pause_menu/inventory/player_inventory.tres" )

var player= Player
var health: float
var max_hp: float


func _ready() -> void:
	add_player_instance()



func add_player_instance() -> void:
	player=PLAYER.instantiate()
	add_child(player)
