extends Node2D

var selectionIndex: Vector2
export var selectionMoveSpd = 1.0
export var dampSpd = 0.8 
var selectionAcc = Vector2.ZERO
var cellPos:Vector2


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selectionIndex = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_selection()

	if Input.is_action_just_pressed("ui_accept"):
		$selectedTileMap.set_cell(floor(selectionIndex.x)/8, floor(selectionIndex.y)/8, 0)

func move_selection() -> void:
	var selectionDirection = Vector2.ZERO
	$targetingTileMap.clear()
	if Input.is_action_pressed("ui_right"):
		selectionDirection.x += 1
	if Input.is_action_pressed("ui_left"):
		selectionDirection.x -= 1
	if Input.is_action_pressed("ui_down"):
		selectionDirection.y += 1
	if Input.is_action_pressed("ui_up"):
		selectionDirection.y -= 1

	selectionDirection = selectionDirection.normalized()
	selectionAcc += selectionDirection*selectionMoveSpd
	selectionAcc *= dampSpd

	selectionIndex += selectionAcc

	if selectionIndex.x < 0:
		selectionIndex.x = get_viewport().size.x - 0.1
	if selectionIndex.y < 0:
		selectionIndex.y = get_viewport().size.y-0.1
	if selectionIndex.x >= get_viewport().size.x:
		selectionIndex.x = 0
	if selectionIndex.y >= get_viewport().size.y:
		selectionIndex.y = 0

	$Target.position = selectionIndex + $blockTileMap.position
	$targetingTileMap.set_cell(floor(selectionIndex.x)/8, floor(selectionIndex.y)/8, 0)
