class_name Slime extends CharacterBody2D

var player_detected : bool =false
var cardinal_direction: Vector2 =Vector2.ZERO
var direction: Vector2 = Vector2.ZERO
var state: String ="idle"
@export var speed: float = 50.0
@export var health : float = 100.0
var in_reach: bool = false
var cool_down: bool = false
var is_dead: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var player: Player = $"../../Player"

@onready var health_bar: ProgressBar = $health


func ennemi():
	pass

func _ready() -> void:
	animation_player.play("idle_down")


func _process(delta: float) -> void:
	damage()
	cal_velocity()
	
	if is_dead==false:
		if SetDirection() or SetState():

			UpdateAnimation()
	else:
		animation_player.play("death")
		
			
	pass
func _physics_process(delta: float) -> void:
	move_and_slide()



	




func _on_detection_body_entered(body: Node2D) -> void:

	if body.has_method("player"):
		player_detected=true
		direction=position-body.position+Vector2(20,20)
func _on_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_detected=false




func _on_hurt_box_area_entered(area: Area2D) -> void:

	if area.get_parent().name=="Player" :
		in_reach=true
func _on_hurt_box_area_exited(area: Area2D) -> void:
	if area.get_parent().name=="Player":
		in_reach=false

func _on_cool_down_timeout() -> void:
	cool_down=false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if is_dead:
		queue_free()
		





func cal_velocity():
	if player_detected:
		direction=position-player.position-Vector2(20,20)
		velocity = -direction.normalized() * speed
	else:
		velocity=Vector2(0,0)

func SetDirection() -> bool:
	var new_direction : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	else:
		new_direction=Vector2.LEFT if direction.x>0 else Vector2.RIGHT
	if new_direction==cardinal_direction:
		return false
	cardinal_direction=new_direction
	sprite.scale.x=-1 if cardinal_direction==Vector2.LEFT else 1
	return true 

func SetState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "move" 
	if new_state == state:
		return false
	state=new_state
	return true

func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side" 

func damage():
	if in_reach and player.player_is_attacking:
		if cool_down==false:
			health+=-30
			if health<0:
				health=0
				is_dead=true
			health_bar.value=health
			cool_down=true
			$cool_down.start()
	
