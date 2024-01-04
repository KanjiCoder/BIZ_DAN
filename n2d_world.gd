extends Node2D
### TODO_NOTES #################################################################
###
### TODO_001 :
### You need to know when to use[ WINDOW_SIZE ]and when to use[ SCREEN_SIZE ].
### Some of your calculations are off because you need to use the CLIENT_AREA
### [ WINDOW_SIZE ]and not the scree_size .
###
### TODO_002 : RESET_FUNCTIONALITY , and bind it to "R" key for DEBUG
### TODO_003 : Move Dan Using The Mouse
### TODO_004 : Random X Spawn Position For Hay 
### TODO_005 : Win Game When Hit Hay , Lose Game If Not Hit Hay
### TODO_006 : Animate Hay Scrolling Into Focus , probably can do this by
###		     : parenting the hay to the background image , and then
### 		 : modifying background code scroll to use[ .position ]
### 		 : instead of[ .offset ]
###
################################################################# TODO_NOTES ###
### WE_CAN_SORT_THIS_LATER #####################################

var WORLDDATA_invincible_grace_period_countdown : int =( 0 )



##################################### WE_CAN_SORT_THIS_LATER ###
### MORE_WORLD_DATA ############################################################

var WORLDDATA_has_hay : bool = false 
var WORLDDATA_s2d_hay : Sprite2D = null 
var WORLDDATA_hay_is_visible : int =( 0 )

@onready var WORLDDATA_psr_hay : PackedScene = preload( "res://s2d_hay.tscn" )

var WORLDDATA_array_goose_length =( 0 )
var WORLDDATA_array_goose     = [ null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								]
var WORLDDATA_array_explosion_length =( 0 )
var WORLDDATA_array_explosion = [ null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								]
var WORLDDATA_array_cloud_length =( 0 )
var WORLDDATA_array_cloud     = [ null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								, null,null,null,null,null,null,null,null,null,null
								]

### ######################################################## MORE_WORLD_DATA ###
### FUCKING_HACKS ##############################################################

var DANDATA_s2d_dan : Sprite2D = null 

############################################################## FUCKING_HACKS ###
### MAINCODE ##################################################--###############

@onready var nod_configcode = get_node( "NOD_CONFIGCODE" )
@onready var nod_cloudcode  = get_node( "NOD_CLOUDCODE"  )
@onready var nod_birdcode   = get_node( "NOD_BIRDCODE"   )
@onready var nod_spawncode  = get_node( "NOD_SPAWNER"    )
@onready var nod_dancode    = get_node( "NOD_DANCODE"    )

var WORLDDATA_has_process_been_hit_at_least_once : int =( 0 )

func  WORLDFUNC_you_died( ) :
	print( "[_WORLD_CODE_YOU_DIED_]" )
	WORLDDATA_invincible_grace_period_countdown =( 100 )
	WORLDCODE_reset_and_start_level()
	pass

func  WORLDCODE_reset_and_start_level( ) :

	print( "[n2d_world.gd:Reset_And_Start_Level]")

	nod_birdcode .BIRDFUNC_free_all_the_fucking_geese()  
	nod_cloudcode.CLOUDFUNC_free_all_clouds()

	WORLDFUNC_ready() 

# Called when the node enters the scene tree for the first time.
func _ready():
	print( "[_N2D_WORLD_CODE_READY_FUNCTION_CALLED_]" )
	WORLDFUNC_ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	if( WORLDDATA_has_process_been_hit_at_least_once <= 0 ) :
		WORLDDATA_has_process_been_hit_at_least_once =( 1 )
		print( "[_WORLD_PROCESS_HIT_]")
		pass
	SCREENCODE_process()
	INPUTCODE_main_outermost_input_handler()
	pass
	
func _physics_process( _delta ) :
	WORLDFUNC_process_physics( )
	pass

###############--################################################## MAINCODE ###
### WORLDDATA #################################################--###############
pass
var WORLDDATA_n2d_world : Node2D = self 
var WORLDDATA_psr_background : PackedScene = preload( "res://s2d_background.tscn" )
var WORLDDATA_s2d_background : Sprite2D = null 
var WORLDDATA_s2d_background_count : int =( 0 )
var WORLDDATA_percent_scroll : float = 0
### WORLDDATA_percent_scroll_per_frame : float = 0    #### USE : WORLDDATA_game_duration_in_ticks ##
### WORLDDATA_game_duration_in_minutes : float = 1.5
var WORLDDATA_game_duration_in_ticks   : int   =( 0 ) #### CALCULATED ####
var WORLDDATA_game_time_in_ticks       : int ## SET_IN_INITIALIZER ##
pass
## Min/Max vertical offset .
##  WORLDDATA_background_min_offset <-- USE[ offset_start ]
##  WORLDDATA_background_max_offset <-- USE[ offset_end   ]
var WORLDDATA_background_offset_start : float =( 0.0 )
var WORLDDATA_background_offset_end   : float =( 0.0 )
var WORLDDATA_background_offset_range : float =( 0.0 )
##
## I am guessing that maybe the offset amount needs to be
## divided by the background scale , because scale is
## affecting the offset ? Just a guess .
var WORLDDATA_background_scale : float =( 1.0 )
								
###############--################################################## WORLDDATA ##
### SCREENCODE ################################################--###############
pass
var int_primary_screen : int
var int_active_screen  : int
pass
var int_screen_count   : int
var int_can_touch      : bool 
var rec_display_safe   : Rect2i    ### @rec@ : Rectangle    ###
pass
var int_screen_dpi     : int 
var iv2_screen_size    : Vector2i  ### @iv2@ : Int_Vector_2 ###
var rec_screen_area    : Rect2i    ### @rec@ : Rectangle    ###
pass
var SCREENCODE_full_screen_cooldown : int =( 0 )
pass
###############--################################################ SCREENCODE ###
### WORLDFUNC #################################################--###############

func WORLDFUNC_err( i_err_msg : String ) :
	print( "[_WORLDFUNC_ERROR_]:" , i_err_msg )
	pass

func WORLDFUNC_INI():

	WORLDDATA_game_time_in_ticks =( 0 )
	WORLDFUNC_hay_hide( ) ## Hide hay stack at start of game ###

	if( nod_configcode.CONFIGDATA_start_with_3_seconds_left ) :
		nod_configcode.CONFIGDATA_game_duration_in_minutes =( 3.0/60.0 )
		
	var fps =( 60 )
	var minutes = nod_configcode.CONFIGDATA_game_duration_in_minutes
	WORLDDATA_game_duration_in_ticks =int( minutes * 60 * fps )

	##__REFACTORED_INTO_READY__#################################

	if( null == WORLDDATA_s2d_background ):
		WORLDDATA_s2d_background = WORLDDATA_psr_background.instantiate()
		WORLDDATA_n2d_world.add_child( WORLDDATA_s2d_background )
		WORLDDATA_s2d_background_count +=( 1 )
		if( WORLDDATA_s2d_background_count > 1 ) :
			WORLDFUNC_err( "[_TOO_MANY_BACKGROUNDS_]" )
		pass
	pass
	_on_viewport_size_changed()
	get_tree().root.connect("size_changed", _on_viewport_size_changed )
	pass
	pass
	## SCREENCODE_hide_screen_edge_panel()
	pass # Replace with function body.
	## p_rint( "[_N2D_WORLD_SAYS_:_DAN_VAR_]" , nod_dancode.dan_var )
	## nod_dancode.DANFUNC_spawn_dan_at_start_position()
	## nod_dancode.DANFUNC_ready( )

	#################################__REFACTORED_INTO_READY__##


func WORLDFUNC_ready( ):

	self.            WORLDFUNC_INI()
	nod_configcode. CONFIGFUNC_INI()
	nod_cloudcode.   CLOUDFUNC_INI()
	nod_spawncode.   SPAWNFUNC_INI()
	nod_dancode.       DANFUNC_INI()

 
func WORLDFUNC_hay_hide() :

	## ABOUT FUNCTION : INSTANTLY HIDES HAY STACK IF EXISTS ####

	if( false == WORLDDATA_has_hay ) :
		pass ## do nothing
	if( true  == WORLDDATA_has_hay ) :
		WORLDDATA_hay_is_visible =( 0 )
		WORLDDATA_s2d_hay.visible = false

func WORLDFUNC_hay_show() :

	## ABOUT_FUNCTION : ANIMATES THE APPEARANCE OF HAY STACK ###

	if( false == WORLDDATA_has_hay ) :
		WORLDDATA_s2d_hay = WORLDDATA_psr_hay.instantiate()
		WORLDDATA_has_hay = true
		var client_area : Vector2i = DisplayServer.window_get_size( 0 )
		var hay_hig : float = WORLDDATA_s2d_hay.texture.get_height()
		WORLDDATA_s2d_hay.position.x =( client_area.x / 2 )
		WORLDDATA_s2d_hay.position.y =( client_area.y - (hay_hig/2) )
		WORLDDATA_n2d_world.add_child( WORLDDATA_s2d_hay )
	if( 0 == WORLDDATA_hay_is_visible ) :
		WORLDDATA_hay_is_visible  =( 1 )
		WORLDDATA_s2d_hay.visible = true 
		pass


## Call this to move dan to the ground where hopefully he will
## intersect with the hay stack .
func WORLDFUNC_process_physics_falltime( ):

	############################################################
	## WHERE THE FUCK IS[ n2d_dan ] ?                  #########
	## Must be a persistent instance that was designed #########
	## into the scene instead of instantiated like     #########
	## the geese and clouds.                           #########
	##                                                 #########
	## ANSWER : DANDATA_s2d_dan                        #########
	##        : ( s2d_dan != n2d_dan )                 #########
	############################################################

	WORLDFUNC_hay_show() ## Show the hay , but animate into frame ##
		
	pass

func WORLDFUNC_process_physics( ):

	INPUTCODE_reset_key_cooldown -=( 1 )
	WORLDDATA_invincible_grace_period_countdown -=( 1 )
	WORLDDATA_game_time_in_ticks +=( 1 )

	if( WORLDDATA_game_time_in_ticks >= WORLDDATA_game_duration_in_ticks ) :
		WORLDDATA_game_time_in_ticks  = WORLDDATA_game_duration_in_ticks
		pass
	var tik_all : float =( WORLDDATA_game_duration_in_ticks )
	var tik_cur : float =( WORLDDATA_game_time_in_ticks     )
	pass
	WORLDDATA_percent_scroll =float( tik_cur / tik_all )
	var bg_offset_subtract =( WORLDDATA_background_offset_range * WORLDDATA_percent_scroll )
	var bg_offset_current  =( WORLDDATA_background_offset_start - bg_offset_subtract )
	##WORLDDATA_s2d_background.offset.y -=( 1 )
	WORLDDATA_s2d_background.offset.y =( bg_offset_current / WORLDDATA_background_scale )
	##WORLDDATA_s2d_background.offset.y =( -6901 / 2 )
	##p_rint( "[_bg_offset_current_]:" , bg_offset_current               ) ## LOOKS_GOOD
	##p_rint( "[_bg_offset_end_____]:" , WORLDDATA_background_offset_end ) ## LOOKS_GOOD
	##p_rint( WORLDDATA_percent_scroll ) <-- LOOKS_GOOD
	pass
	if( WORLDDATA_percent_scroll >= 1) :
		##p_rint( "[n2d_world.gd:_TIME_TO_FALL_]")
		WORLDFUNC_process_physics_falltime()

func WORLDFUNC_update_world_object_scales( ) :
	var bg_wid : float = WORLDDATA_s2d_background.texture.get_width()
	var bg_hig : float = WORLDDATA_s2d_background.texture.get_height()
	var vp_wid : float = iv2_screen_size.x
	var vp_hig : float = iv2_screen_size.y
	## formula : vp_wid =( bg_wid * mult_wid )
 	##         : vp_wid /  bg_wid = mult_wid
	## formula : vp_hig =( bg_hig * mult_hig )
 	##         : vp_hig /  bg_hig = mult_hig
	var mult_wid : float =( vp_wid / bg_wid )
	### mult_hig : float =( vp_hig / bg_hig )
	var mult_sqr : float =( mult_wid )
	WORLDDATA_s2d_background.scale.x =( mult_sqr )
	WORLDDATA_s2d_background.scale.y =( mult_sqr )
	## p_rint( bg_wid )
	## p_rint( vp_wid )
	## p_rint( mult_wid )
	WORLDDATA_s2d_background.offset.x =( bg_wid / 2 ) ## center background ##
	pass
	##  scaled_bg_wid : float =( bg_wid * mult_sqr )
	var scaled_bg_hig : float =( bg_hig * mult_sqr )
	var travel_pixels : float =( scaled_bg_hig - vp_hig )
	pass
	WORLDDATA_background_offset_end   =( 0.0 - ( travel_pixels / 2.0 ) )
	WORLDDATA_background_offset_start =( 0.0 + ( travel_pixels / 2.0 ) )
	WORLDDATA_background_offset_range =(         travel_pixels         )
	pass
	##
	## $_DIAGRAM_HALF_VIEWPORT_HEIGHT_OFFSET_$ VVVVVVV
	WORLDDATA_background_offset_end   +=( vp_hig / 2 )
	WORLDDATA_background_offset_start +=( vp_hig / 2 )
	##
	pass
	##p_rint( "[_travel_pixels_]:" , travel_pixels )
	##p_rint( "[_WORLDDATA_background_offset_start_]:" , WORLDDATA_background_offset_start )
	##p_rint( "[_WORLDDATA_background_offset_end___]:" , WORLDDATA_background_offset_end   )
	##p_rint( "[_WORLDDATA_background_offset_range_]:" , WORLDDATA_background_offset_range )
	pass 
	WORLDDATA_background_scale =( mult_sqr )

###############--################################################# WORLDFUNC ###
### SCREENCODE ################################################--###############

func SCREENCODE_process( ) :
	SCREENCODE_full_screen_cooldown -=( 1 )

func SCREENCODE_collect_screen_settings( ):
	int_primary_screen = DisplayServer.get_primary_screen( )
	int_active_screen  = SCREENCODE_what_screen_is_my_window_on()
	var p_s : int =( int_primary_screen )
	var a_s : int =( int_active_screen  )
	if( p_s ) : pass
	if( a_s ) : pass
	pass
	int_screen_count   = DisplayServer.get_screen_count(           ) 
	int_can_touch      = DisplayServer.is_touchscreen_available(   )
	rec_display_safe   = DisplayServer.get_display_safe_area(      )
	pass
	int_screen_dpi     = DisplayServer.screen_get_dpi(         a_s )
	iv2_screen_size    = DisplayServer.screen_get_size(        a_s )
	rec_screen_area    = DisplayServer.screen_get_usable_rect( a_s )
	
func SCREENCODE_snap_screen_to_collected_settings( ):
	var pan_screen_edges : Panel = get_node( "PAN_SCREEN_EDGES" )
	pan_screen_edges.position.x = 0 
	pan_screen_edges.position.y = 0
	pan_screen_edges.size.x = iv2_screen_size.x
	pan_screen_edges.size.y = iv2_screen_size.y
	
func _on_viewport_size_changed( ):
	SCREENCODE_collect_screen_settings()
	SCREENCODE_snap_screen_to_collected_settings()
	WORLDFUNC_update_world_object_scales()
	print ("Viewport size changed")
	pass
	
func SCREENCODE_what_screen_is_my_window_on( ):
	var screen_id : int = DisplayServer.window_get_current_screen( 0 ) 
	return screen_id 

func SCREENCODE_hide_screen_edge_panel( ) :
	var pan_screen_edges : Panel = get_node( "PAN_SCREEN_EDGES" )
	pan_screen_edges.visible = false

##   SCREENCODE_enter_full_screen( ) :
func SCREENCODE_make_window_full_screen( ) :
	### screen_id : int = DisplayServer.window_get_current_screen( 0 )
	var window_id = DisplayServer.MAIN_WINDOW_ID
	var FULLSCREEN : int = DisplayServer.WINDOW_MODE_FULLSCREEN 
	DisplayServer.window_set_mode( FULLSCREEN  , window_id )
	WORLDFUNC_update_world_object_scales()
	pass

func SCREENCODE_exit_full_screen( ) :
	### var screen_id : int = DisplayServer.window_get_current_screen( 0 )
	var window_id = DisplayServer.MAIN_WINDOW_ID
	var WINDOWED : int = DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode( WINDOWED  , window_id )
	WORLDFUNC_update_world_object_scales()
	pass

func SCREENCODE_toggle_full_screen_on_off() :
	pass
	### screen_id : int = DisplayServer.window_get_current_screen( 0 )
	var window_id = DisplayServer.MAIN_WINDOW_ID
	var int_window_mode = DisplayServer.window_get_mode( window_id )
	pass
	var FULLSCREEN : int = DisplayServer.WINDOW_MODE_FULLSCREEN 
	var WINDOWED : int = DisplayServer.WINDOW_MODE_WINDOWED
	pass
	### THESE_FUNCS_CALL[ WORLDFUNC_update_world_object_scales ]
	if( int_window_mode == FULLSCREEN ) : SCREENCODE_exit_full_screen( )
	if( int_window_mode == WINDOWED   ) : SCREENCODE_make_window_full_screen()
	pass

###############--################################################ SCREENCODE ###
### INPUTCODE #################################################--###############

var INPUTCODE_reset_key_cooldown : int = 0 

func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		## p_rint("Mouse Click/Unclick at: ", event.position)
		pass
	elif event is InputEventMouseMotion:
		## print("Mouse Motion at: ", event.position)
		pass
		if( null != DANDATA_s2d_dan ) :
			DANDATA_s2d_dan.position.x = event.position.x
	##	## p_rint("Mouse Motion at: ", event.position)

func INPUTCODE_main_outermost_input_handler( ) :
	if Input.is_key_pressed( KEY_R ) :
		if( INPUTCODE_reset_key_cooldown <= 0 ) :
			WORLDCODE_reset_and_start_level()
			INPUTCODE_reset_key_cooldown = 15 
	if Input.is_key_pressed( KEY_F ) :
		if( SCREENCODE_full_screen_cooldown <= 0 ) :
			SCREENCODE_full_screen_cooldown = 100
			SCREENCODE_toggle_full_screen_on_off()
		else : 
			pass
	if Input.is_key_pressed( KEY_ESCAPE ) :
		SCREENCODE_exit_full_screen()
	pass

###############--################################################# INPUTCODE ###

################################################################
##                                                            ##
## $_DIAGRAM_HALF_VIEWPORT_HEIGHT_OFFSET_$                    ##
##                                                            ##
## @VP@  : ViewPort                                           ##
## @SBG@ : Scrolling_Back_Ground                              ##
## @CEN@ : ViewPort_Center                                    ##
##                                 SBG                        ##
##                                   \                        ##
##                                    [1][ ][ ]               ##
##                                    [2]   [ ]               ##
##                                    [3]   [ ]               ##
##                                    [4]   [ ]               ##
##                                    [5]   [ ]               ##
##           VP                       [6]   [ ]               ##
##            \                       [7][ ][ ]               ##
##             [1][ ][ ][ ][ ][ ][ ]  [8][ ][ ]               ##
##             [2]               [ ]  [9]   [ ]               ##
##             [3]               [ ]  [0]   [ ]               ##
##             [4]      CEN      [ ]  [1]_0_[ ] <-- ZERO_OFFSET
##             [5]               [ ]  [2]   [ ]               ##
##             [6]               [ ]  [3]   [ ]               ##
## 07_PIXELS-->[7][ ][ ][ ][ ][ ][ ]  [4][ ][ ]               ##
##                                    [5][ ][ ]               ##
##                                    [6]   [ ]               ##
##                                    [7]   [ ]               ##
##                                    [8]   [ ]               ##
##                                    [9]   [ ]               ##
## 21_PIXELS-------------->>>>>>>>>>>>[0]   [ ]               ##
##                                    [1][ ][ ]               ##
##                                                            ##
##                                                            ##
## travel_distance =( SBG.wid - VP.wid )                      ##
## min_os =( 0 - ( travel_distance / 2 ) ) //: ending___offset##
## max_os =( 0 + ( travel_distance / 2 ) ) //: starting_offset##
##                                                            ##
## travel_distance =( 21 - 7 )=( 14 )                         ##
##                                                            ##
## THIS IST CORRECT BECAUSE[ _0_ ]LATCHES_TO[ VP ]            ##
## AND_NOT_ONTO[ CEN ], SO_YOU_MUST_ADD_HALF_THE              ##
## VIEWPORT_HEIGHT_TO[ min_os ]AND[ max_os ]                  ##
##                                                            ##
## min_os = min_os + ( VP.hig / 2 )                           ##
## max_os = max_os + ( VP.hig / 2 )                           ##
##                                                            ##
################################################################
##__REFACTORED_INTO_READY__#####################################
##                                                            ##
##  Code refactored into the WORLDFUNC_ready() function       ##
##  so that we can easily do a reset of the game state .      ##
##                                                            ##
##                                                            ##
#####################################__REFACTORED_INTO_READY__##
