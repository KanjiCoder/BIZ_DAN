extends Node

@onready var n2d_world : Node2D = get_tree().root.get_child(0)
var BIRDDATA_has_process_been_hit_at_least_once : int =( 0 )
var BIRDDATA_psr_goose_001 : PackedScene = preload( "res://s2d_goose.tscn")

func BIRDFUNC_spawn_goose_by_percent( percent_x ) :
	var s2d_goose = null
	s2d_goose = BIRDDATA_psr_goose_001.instantiate()
	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	var spawn_pos_y =(  client_area.y + 128 ) ## goose fully off screen ##
	var spawn_pos_x =(float( client_area.x - 1 ))*(float(percent_x))
	s2d_goose.offset.x =( spawn_pos_x )
	s2d_goose.offset.y =( spawn_pos_y )
	n2d_world.add_child( s2d_goose )

func _physics_process( _delta ):
	if( BIRDDATA_has_process_been_hit_at_least_once <= 0 ) :
		BIRDDATA_has_process_been_hit_at_least_once =( 1 )
		pass
	pass
pass

func _ready():
	pass # Replace with function body.
func _process( _delta ):
	pass
