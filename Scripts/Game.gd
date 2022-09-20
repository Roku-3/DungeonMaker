extends Node2D

var selectionIndex: Vector2
export var selectionMoveSpd = 1.0
export var dampSpd = 0.8 
var selectionAcc = Vector2.ZERO
var cellPos:Vector2

func _ready() -> void:
	selectionIndex = Vector2(0,0)

func _process(delta: float) -> void:
	# var cellPos =  Vector2(floor(selectionIndex.x)/8, floor(selectionIndex.y)/8)
	var mousePos = get_local_mouse_position()
	cellPos =  Vector2(floor(mousePos.x/8),floor(mousePos.y/8))
	# ホバーしているところを光らせる
	$targetingTileMap.clear()
	$Target.position = mousePos + $blockTileMap.position

	# 左クリックでタイルを選択
	if Input.is_action_pressed("leftClick"):
		# 十字の形で選択
		for cellOffset in [ Vector2.ZERO, Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]:
			if $blockTileMap.get_cellv(cellPos+cellOffset) != -1:
				$selectedTileMap.set_cellv(cellPos+cellOffset, 0)
	# 右クリックで選択を解除
	if Input.is_action_pressed("rightClick"):
		for cellOffset in [ Vector2.ZERO, Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]:
			if $blockTileMap.get_cellv(cellPos+cellOffset) != -1:
				$selectedTileMap.set_cellv(cellPos+cellOffset, -1)
