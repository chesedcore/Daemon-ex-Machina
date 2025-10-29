class_name TileHandler extends Node2D

@export var node_layer: TileMapLayer
@export var reserved_layer: TileMapLayer
@export var game_nodes: Node2D
@export var node_preload: PackedScene
@export var player: Marker2D


@export var player_visual_position := Vector2i(0,0):
	set(val):
		player_visual_position = val
		player.position = get_pos_from(val)

func _process(_delta: float) -> void:
	detect_movement()

func _ready() -> void:
	place_node_at(Vector2i(0,0))
	player.position = get_pos_from(player_visual_position)

func detect_movement() -> void:
	var dir := Vector2i.ZERO
	if Input.is_action_just_pressed("up"): dir = Vector2i.UP
	elif Input.is_action_just_pressed("down"): dir = Vector2i.DOWN
	elif Input.is_action_just_pressed("right"): dir = Vector2i.RIGHT
	elif Input.is_action_just_pressed("left"): dir = Vector2i.LEFT
	if dir == Vector2i.ZERO: return
	
	player_visual_position += dir
	

func get_pos_from(tile: Vector2i) -> Vector2:
	return node_layer.map_to_local(tile)

func place_node_at(tile: Vector2i) -> void:
	var node: GameNode = node_preload.instantiate()
	var target_position := node_layer.map_to_local(tile)
	node.position = target_position
	game_nodes.add_child(node)
