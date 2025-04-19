extends Node
var all_direction=["down","up","left","right"]
var all_movement={"down":Vector2(0,1),"up":Vector2(0,-1),"left":Vector2(-1,0),"right":Vector2(1,0)}
var current_world : String ="world"
var list_world=["world","maison","dungeon"]
var is_changing_world=false
var day : bool = true
var time_day=Timer.new()
var time_night=Timer.new()
var play_load_direction:Vector2=Vector2.ZERO


func _ready() -> void:
	add_child(time_day)
	add_child(time_night)
	time_day.wait_time=60
	time_night.wait_time=60
	time_day.one_shot = true
	time_night.one_shot = true
	time_day.connect("timeout", Callable(self, "_on_day_timeout"))
	time_night.connect("timeout", Callable(self, "_on_night_timeout"))
	time_day.start()

	


func _process(delta: float) -> void:
	
	pass
func _on_day_timeout():
	print("nuit")
	day=false
	time_night.start()
func _on_night_timeout():
	print("jour")
	day=true
	time_day.start()
