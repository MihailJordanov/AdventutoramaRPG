class_name HitBox extends Area2D

signal Damaged( damage : int )

func TakeDamage( damage : int ):
	print( "TakeDamag: ", damage )
	Damaged.emit( damage )	
