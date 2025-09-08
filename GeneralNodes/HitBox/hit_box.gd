class_name HitBox extends Area2D

signal Damaged( hurt_box : HurtBox )

func _ready() -> void:
	pass	

func TakeDamage( hurt_box : HurtBox ):
	Damaged.emit( hurt_box )	
