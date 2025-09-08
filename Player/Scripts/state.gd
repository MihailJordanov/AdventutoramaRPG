class_name State  extends Node

static var player : Player
static var state_machine : PlayerStateMachine

func  _ready():
	pass
	
func init():
	pass
	
func Enter():
	pass
	
func Exit():
	pass
	
func Process(_delta : float) -> State:
	return null
	
func Physics(_delta : float) -> State:
	return null

func HandleInput(_event : InputEvent) -> State:
	return null
