extends Node

@onready var n2d_world : Node2D = get_tree().root.get_child(0)
var BIRDDATA_has_process_been_hit_at_least_once : int =( 0 )
var BIRDDATA_psr_goose_001 : PackedScene = preload( "res://s2d_goose.tscn")

func BIRDFUNC_free_all_the_fucking_geese( ) :
	for _i_ in range( 0 , (100-1) ) :
		print( "[_TODO_FREE_ALL_THE_GEESE_]" )


func BIRDFUNC_add_goose_to_manager_array( s2d_goose ):
	var dex : int 
 
	## Reset Array Size And Use Oldest Slot ##
	if( n2d_world.WORLDDATA_array_goose_length >= 100 ) :
		n2d_world.WORLDDATA_array_goose_length =( 0 )
		pass
	dex = n2d_world.WORLDDATA_array_goose_length 
	n2d_world.WORLDDATA_array_goose_length += 1
	pass
	var new_goose =( s2d_goose )
	var old_goose =( n2d_world.WORLDDATA_array_goose[ dex ] )
	n2d_world.WORLDDATA_array_goose[ dex ]=( new_goose )

	## Help us avoid trying to free stale 
	## object references 
	new_goose.m_manager_index =( dex )

	## Free previous goose if it exists 
	if( null != old_goose ) :
		## DONT_FUCKING_DO_THIS_REFERENCE_COULD_BE_STALE
		## THE_GOOSE_SHOULD_USE_ITS[ m_manager_index ]
		## to free itself from the[ WORLDDATA_array_goose ]
		pass

func BIRDFUNC_spawn_goose_by_percent( percent_x ) :
	var s2d_goose = null
	s2d_goose = BIRDDATA_psr_goose_001.instantiate()
	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	var spawn_pos_y =(  client_area.y + 128 ) ## goose fully off screen ##
	var spawn_pos_x =(float( client_area.x - 1 ))*(float(percent_x))
	s2d_goose.position.x =( spawn_pos_x )
	s2d_goose.position.y =( spawn_pos_y )
	n2d_world.add_child( s2d_goose )
	BIRDFUNC_add_goose_to_manager_array( s2d_goose )


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
