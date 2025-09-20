class_name Plant extends Node2D

@export var is_hittble : bool = true
@export var health : int = 1
@export var take_damage_sound : AudioStream 


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	$HitBox.Damaged.connect( TakeDamage )
	audio.stream
	pass
	
	
func TakeDamage( hurt_box : HurtBox ):
	if is_hittble == false:
		return
	health -= 1
	animation_player.play("take_damage")
	
	audio.stream = take_damage_sound
	audio.pitch_scale = randf_range(8.9 , 1.1)
	audio.play()
	
	audio.play()
	if health <= 0:
		queue_free()
	pass
