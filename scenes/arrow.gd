extends Sprite2D

@onready var arc: Sprite2D = $".."


@onready var player: Player = $"../.."

@export var speed: float =100

var arrow_target:Vector2
var deplacement:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction_target()


	if Input.is_action_just_pressed("arc"):
		visible=true

	position+=deplacement.normalized()*speed
	

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		arrow_target=get_global_mouse_position()
		

func direction_target():
	var angle : float
	
	
	deplacement=arrow_target-global_position


	angle=atan2(deplacement.y,deplacement.x)
	if arc.rotation==0:
		rotation=angle+PI
	else:
		rotation=angle
