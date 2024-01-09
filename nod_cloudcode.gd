extends Node

@onready var n2d_world : Node2D = get_tree().root.get_child(0)
## @onready var nod_configcode= get_node("/root/N2D_WORLD/NOD_CONFIGCODE")

var CLOUDDATA_has_process_been_hit_at_least_once : int =( 0 )
var CLOUDDATA_psr_cloud_001 : PackedScene = preload( "res://s2d_cloud_001.tscn")
var CLOUDDATA_psr_cloud_002 : PackedScene = preload( "res://s2d_cloud_002.tscn")

func CLOUDFUNC_err( i_msg : String ) :
	print( "[_CLOUDFUNC_ERROR_]:" , i_msg )

func CLOUDFUNC_init_cloud_speed( n2d_cloud ) :

	var fall_speed_in_pixels_per_frame_at_60fps=( 
		n2d_world.nod_configcode.CONFIGDATA_fall_speed_in_pixels_per_frame_at_60fps
	)
	n2d_cloud.cloudspeed =( fall_speed_in_pixels_per_frame_at_60fps )
	

func CLOUDFUNC_free_all_clouds(  ) :
	for _i_ in range( 0 , (100-1) ) :
		var s2d_cloud = n2d_world.WORLDDATA_array_cloud[ _i_ ]
		if( null != s2d_cloud ) :
			var dex =( s2d_cloud.m_manager_index )
			if( dex != _i_ ) :
				## Manager code is broken.
				CLOUDFUNC_err( "[_DEX_NOT_EQUAL_TO_I_]" )
			else :
				n2d_world.WORLDDATA_array_cloud[ dex ] =( null )
				s2d_cloud.queue_free( )

	## JBI_021 #################################################
	##                                                        ##
	##  Cloud management code was broken.                     ##
	##  So that probably means our bird management            ##
	##  code is also broken. FIX BIRD MANAGEMENT IN[ JBI_022 ]##
	##                                                        ##
	############################################################
	for _i_ in range( 0 , (100-1 ) ) :
		n2d_world.WORLDDATA_array_cloud[ 0 ] =( null )
	n2d_world.WORLDDATA_array_cloud_length =( 0 ) ## RESET LENGTH AFTER FREEING ALL ##

	################################################# JBI_021 ##

func CLOUDFUNC_free_cloud( s2d_cloud ) :

	var dex =( s2d_cloud.m_manager_index )
	var quantum_cloud =( n2d_world.WORLDDATA_array_cloud[ dex ] )
	if( quantum_cloud == s2d_cloud ) :

		if( quantum_cloud.m_manager_index != s2d_cloud.m_manager_index ) :
			CLOUDFUNC_err( "[_YOUR_MANAGING_CODE_IS_BROKEN_]" )
		else :
			n2d_world.WORLDDATA_array_cloud[ dex ] =( null )
			s2d_cloud.queue_free( )
			

func CLOUDFUNC_add_cloud_to_cloud_manager( s2d_cloud ) :

	## If over capacity , start re-writing slots ##
	if( n2d_world.WORLDDATA_array_cloud_length > 100 ) :
		n2d_world.WORLDDATA_array_cloud_length =( 0 )

	## Add the cloud to managing array so we can  
	## free them all when the time is right .
	## Or... Instead of directly freeing them...
	## We could just increase the velocity of all
	## the clouds to rush them off screen.
	n2d_world.add_child( s2d_cloud )
	var dex = n2d_world.WORLDDATA_array_cloud_length
	s2d_cloud.m_manager_index =( dex )
	n2d_world.WORLDDATA_array_cloud[ dex ]=( s2d_cloud )
	n2d_world.WORLDDATA_array_cloud_length +=( 1 )


func CLOUDFUNC_spawn_cloud_by_percent( percent_x ) :
	var s2d_cloud = null

	### JBI_021 ################################################
	##                                                        ##
	##  Josh wanted to get rid of the turd clouds .           ##
	##                                                        ##
	############################################################

	var anti_turd =( n2d_world.nod_configcode.CONFIGDATA_get_those_turd_clouds_out_of_my_sight )
	var cloud_1_2 ; ## NOT SET YET ##
	if( anti_turd ) :
		cloud_1_2 =( 1 )
	else :
		var rand_1_2 =( randi_range(1,2)) 
		cloud_1_2 =( rand_1_2 )

	if( cloud_1_2 == 1 ) : s2d_cloud = CLOUDDATA_psr_cloud_001.instantiate()
	if( cloud_1_2 == 2 ) : s2d_cloud = CLOUDDATA_psr_cloud_002.instantiate()

	################################################ JBI_021 ###

	var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	var spawn_pos_y =(  client_area.y + 128 ) ## cloud fully off screen ##
	var spawn_pos_x =(float( client_area.x - 1 ))*(float(percent_x))
	s2d_cloud.offset.x =( spawn_pos_x )
	s2d_cloud.offset.y =( spawn_pos_y )
	pass
	CLOUDFUNC_add_cloud_to_cloud_manager( s2d_cloud )
	
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

func CLOUDFUNC_INI( ):
	print( "[_CLOUDFUNC_INI_]" )
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
