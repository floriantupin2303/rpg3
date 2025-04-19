extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_color(Color(0.8,0.1,0.1,0))
@onready var lights: Node = $"../lights"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global.day==true:
		colour_day()
	if global.day==false:
		colour_night()

func colour_day():
	var color
	var time
	var red
	var green
	var blue 
	var time_total
	var alpha
	var all_lights
	all_lights=lights.get_children()
	
	time=global.time_day.time_left
	time_total=global.time_day.wait_time
	for light in all_lights:
		light.energy=2*(1-time/time_total)
	red=0.8*time/time_total
	green=0.1*time/time_total
	blue=0.1*time/time_total
	alpha=0.8*(1-(time/time_total))
	color=Color(red,green,blue,alpha)
	set_color(color)
	

func colour_night():
	var color
	var time
	var red
	var green
	var blue 
	var time_total
	var alpha
	var all_lights
	all_lights=lights.get_children()
	time=global.time_night.time_left
	time_total=global.time_night.wait_time
	for light in all_lights:
		print(light.energy)
		light.energy=2*time/time_total
	red=0.1*(1-time/time_total)
	green=0.1*(1-time/time_total)
	blue=0.9*(1-time/time_total)
	alpha=0.8*time/time_total
	color=Color(red,green,blue,alpha)
	set_color(color)
