extends Node2D

### MAINCODE ##################################################--###############

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_viewport_size_changed()
	get_tree().root.connect("size_changed", _on_viewport_size_changed )
	## SCREENCODE_hide_screen_edge_panel()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta ):
	SCREENCODE_process()
	INPUTCODE_main_outermost_input_handler()
	pass

###############--################################################## MAINCODE ###
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
	pass

func SCREENCODE_exit_full_screen( ) :
	### var screen_id : int = DisplayServer.window_get_current_screen( 0 )
	var window_id = DisplayServer.MAIN_WINDOW_ID
	var WINDOWED : int = DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode( WINDOWED  , window_id )
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
	if( int_window_mode == FULLSCREEN ) : SCREENCODE_exit_full_screen( )
	if( int_window_mode == WINDOWED   ) : SCREENCODE_make_window_full_screen()
	pass

###############--################################################ SCREENCODE ###
### INPUTCODE #################################################--###############

func INPUTCODE_main_outermost_input_handler( ) :
	if Input.is_key_pressed( KEY_F ) :
		if( SCREENCODE_full_screen_cooldown <= 0 ) :
			SCREENCODE_full_screen_cooldown = 100
			SCREENCODE_toggle_full_screen_on_off()
		else : 
			pass
	pass

###############--################################################# INPUTCODE ###
