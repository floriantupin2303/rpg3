class_name Player 
extends CharacterBody2D


var cardinal_direction: Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
@export var speed : float = 100.0
var state : String = "idle"
var player_is_attacking: bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
var health=100
var max_hp=100

signal camera_change
signal direction_change

func player():
	pass



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	SetDirectionHitBox()
	if velocity==Vector2(0,0):
		attack()
	if not player_is_attacking:
		cal_velocity()
	if SetState() or SetDirection():
		UpdateAnimation()
	pass
	if global.is_changing_world:
		cardinal_direction=global.play_load_direction
		UpdateAnimation()
		change_camera()
		camera_change.emit()

func _physics_process(delta: float) -> void:
	move_and_slide()

	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	player_is_attacking=false


#calcul la vitesse
func cal_velocity() -> void:
	direction.x=(Input.get_action_strength("right")- Input.get_action_strength("left"))
	direction.y=(Input.get_action_strength("down") - Input.get_action_strength("up"))
	direction=direction.normalized()
	velocity = direction * speed
			
#détermine s'il y a eu changement de direction ou non
func SetDirection() -> bool:
	var new_direction : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y ==0:
		new_direction=Vector2.LEFT if direction.x<0 else Vector2.RIGHT
	elif direction.x==0:
		new_direction=Vector2.UP if direction.y<0 else Vector2.DOWN
	if new_direction==cardinal_direction:
		return false
	else:
		direction_change.emit()
	cardinal_direction=new_direction
	sprite.scale.x=-1 if cardinal_direction==Vector2.LEFT else 1
	return true 

#détermine s'il y a eu un changement d'état
func SetState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "move" 
	if player_is_attacking:
		new_state="attack"
	if new_state == state:
		return false
	state=new_state
	return true


#détermine si une attack doit commencer ou non
func attack() -> void:
	if Input.is_action_just_pressed("attack"):
		player_is_attacking=true

#mise à jour de l'animation
func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())
	

#direction de l'animation
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side" 

func SetDirectionHitBox():
	if  cardinal_direction == Vector2.DOWN:
		$hit_box_attack2/hit_box_down.disabled=false
		$hit_box_attack2/hit_box_up.disabled=true
		$hit_box_attack2/hit_box_side.disabled=true
	elif  cardinal_direction == Vector2.UP:
		$hit_box_attack2/hit_box_down.disabled=true
		$hit_box_attack2/hit_box_up.disabled=false
		$hit_box_attack2/hit_box_side.disabled=true
	else:
		$hit_box_attack2/hit_box_down.disabled=true
		$hit_box_attack2/hit_box_up.disabled=true
		$hit_box_attack2/hit_box_side.disabled=false
func change_camera() -> void:
	for world in global.list_world:
		for child in get_children():
			if child.name=="Camera_"+world:
				if world == global.current_world:
					child.enabled=true
				else:
					child.enabled=false
