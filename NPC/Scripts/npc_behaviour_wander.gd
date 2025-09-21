@tool
extends NPCBehaviour

const DIRECTIONS = [ Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT ]

@export var wander_range : int = 2 : set = _set_wander_range
@export var wander_speed : float = 30.0
@export var wander_duration : float = 1.0
@export var idle_duration : float = 1.0

var original_position : Vector2



func _ready() -> void:
	if Engine.is_editor_hint():
		return
	super()
	$CollisionShape2D.queue_free()
	original_position = npc.global_position



func _process(delta: float) -> void:

	if Engine.is_editor_hint():
		return
	if _get_distance_to_original_pos() > _get_wander_distance_px():
		if _get_distance_to_original_pos() < _get_distance_to_original_pos(npc.direction):
			npc.velocity *= -1
			npc.direction *= -1
			npc.update_direction(global_position + npc.direction)
			npc.update_animation()

func _get_distance_to_original_pos(delta : Vector2 = Vector2.ZERO) -> float:
	return abs((npc.global_position + delta).distance_to(original_position))

func _get_wander_distance_px() -> int:
	return wander_range * 32.0



func start() -> void:
	# IDLE PHASE
	if npc.do_behavior == false:
		return
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	await get_tree().create_timer( randf() * idle_duration + idle_duration * 0.5 ).timeout
	# WALK PHASE
	npc.state = "walk"
	var _dir : Vector2 = DIRECTIONS[ randi_range(0,3) ]
	npc.direction = _dir
	npc.velocity = wander_speed * _dir
	npc.update_direction( global_position + _dir )
	npc.update_animation()
	await get_tree().create_timer( randf() * wander_duration + wander_duration * 0.5 ).timeout
	# REPEAT
	if npc.do_behavior == false:
		return
	start()
	pass



func _set_wander_range( v : int ) -> void:
	wander_range = v
	$CollisionShape2D.shape.radius = v * 32.0
