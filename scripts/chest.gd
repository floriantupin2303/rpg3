extends Sprite2D

var player_in_reach: bool =false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and player_in_reach:
		queue_free()



func _on_detection_body_entered(body: Node2D) -> void:
	player_in_reach=true


func _on_detection_body_exited(body: Node2D) -> void:
	player_in_reach=false
