extends Node

@onready var n2d_world : Node2D = get_tree().root.get_child(0)
var CLOUDDATA_has_process_been_hit_at_least_once : int =( 0 )
var CLOUDDATA_psr_cloud_001 : PackedScene = preload( "res://s2d_cloud_001.tscn")
var CLOUDDATA_psr_cloud_002 : PackedScene = preload( "res://s2d_cloud_002.tscn")

func CLOUDFUNC_spawn_cloud_by_percent( percent_x ) :
	var s2d_cloud = null
	var rand_0_1 =( randi_range(0,1)) 
	if( rand_0_1 == 0 ) : s2d_cloud = CLOUDDATA_psr_cloud_001.instantiate()
	if( rand_0_1 == 1 ) : s2d_cloud = CLOUDDATA_psr_cloud_002.instantiate()
	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	var spawn_pos_y =(  client_area.y + 128 ) ## cloud fully off screen ##
	var spawn_pos_x =(float( client_area.x - 1 ))*(float(percent_x))
	s2d_cloud.offset.x =( spawn_pos_x )
	s2d_cloud.offset.y =( spawn_pos_y )
	n2d_world.add_child( s2d_cloud )
	
func CLOUDFUNC_ping() :
	print( "[_IAM_THE_CLOUD_AND_I_EXIST_]" )
	pass
func CLOUDFUNC_random_spawn_point_xy() : 
	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	var spawn_xy : Vector2i  = Vector2i(0,0)
	spawn_xy.x =( randi_range( 0 , client_area.x - 1 ) )
	spawn_xy.y =( client_area.y ) ## Bottom Of Screen ##
	spawn_xy.y +=( 128 ) ## Make sure cloud fully off screen ##
	return( spawn_xy )

func CLOUDFUNC_spawn_cloud_001() :
	var s2d_cloud = CLOUDDATA_psr_cloud_001.instantiate()
	var spawn_xy = CLOUDFUNC_random_spawn_point_xy()
	s2d_cloud.offset.x =( spawn_xy.x )
	s2d_cloud.offset.y =( spawn_xy.y )
	n2d_world.add_child( s2d_cloud )
	pass
	
func CLOUDFUNC_spawn_cloud_002() :
	var s2d_cloud = CLOUDDATA_psr_cloud_002.instantiate()
	var spawn_xy = CLOUDFUNC_random_spawn_point_xy()
	s2d_cloud.offset.x =( spawn_xy.x )
	s2d_cloud.offset.y =( spawn_xy.y )
	n2d_world.add_child( s2d_cloud )
	pass

func CLOUDFUNC_cloud_spawner_process_physics() :
	var r_i : int = randi_range( 0 , 1 )
	if( 0 == r_i ) : CLOUDFUNC_spawn_cloud_001()
	if( 1 == r_i ) : CLOUDFUNC_spawn_cloud_002()
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print( "[_CLOUD_CODE_READY_FUNCTION_CALLED_]" )
	pass # Replace with function body.
	
func _physics_process(_delta):
	## CLOUDFUNC_cloud_spawner_process_physics() <-- DEPRECATED 
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	if( CLOUDDATA_has_process_been_hit_at_least_once <= 0 ) :
		CLOUDDATA_has_process_been_hit_at_least_once =( 1 )
		print( "[_CLOUD_PROCESS_HIT_]" )
		pass
	pass
