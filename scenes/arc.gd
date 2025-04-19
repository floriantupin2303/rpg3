extends Sprite2D

@onready var player: Player = $".."
var arc_direction: String 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	define_arc_direction()
	if Input.is_action_just_pressed("arc"):
		visible=true
	rotate_arc()


	

func define_arc_direction():
	if player.cardinal_direction==Vector2.LEFT:
		arc_direction="left"
	if player.cardinal_direction==Vector2.RIGHT:
		arc_direction="right"


func rotate_arc():
	if arc_direction=="right":
		rotation=PI
	if arc_direction=="left":
		rotation=0
