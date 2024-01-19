extends Node2D
@onready var n2d_world : Node2D = get_tree().root.get_child(0)

var  we_are_going_to_crash =( 0 )

func ERR( msg ) :
	print( "[ N2D_UI.GD : CRASHING ]" )
	print( "[ ERROR_MESSAGE ]:" , msg )
	we_are_going_to_crash =( 1 )
	get_tree().quit() ## AKA : exit ##

func MSG( msg ) :
	print( msg )

func UIFUNC_handle_mouse_event( event ) :
	pass

func UIFUNC_button_position_s2d_n_of_n( btn , num , tot ) :
	var cliarea = UIFUNC_get_client_area() 
	btn.position.x =( cliarea.x / 2 )
	btn.position.y =( cliarea.y / 2 )
		
	if( 2 == tot ) :
		if( 1 == num ) : btn.position.y -=( 32 )
		if( 2 == num ) : btn.position.y +=( 32 )

	else :
		ERR( "[_ONLY_HANDLING_2_BUTTONS_PER_MENU_RIGHT_NOW_]" )
	pass

func UIFUNC_update_control_positions() :

	## var m1_b1 =( $N2D_MENU_START/$BTN_MENU_START ) ## Menu1_Button1
	## var m1_b2 =( $N2D_MENU_START/$BTN_MENU_QUIT  ) ## Menu1_Button2

	## var m1_b1 =( self.N2D_MENU_START.BTN_MENU_START )
	## var m1_b2 =( self.N2D_MENU_START.BTN_MENU_QUIT  )

	var m1_b1 =( $N2D_MENU_START/BTN_MENU_START ) ## Menu1_Button1
	var m1_b2 =( $N2D_MENU_START/BTN_MENU_QUIT  ) ## Menu1_Button2

	if( null == m1_b1 ) : ERR( "[_NIL_:_m1_b1_]" )
	if( null == m1_b2 ) : ERR( "[_NIL_:_m1_b2_]" )

	if( null != m1_b1 ) : MSG( "[_O_K_:_m1_b1_]" )
	if( null != m1_b2 ) : MSG( "[_O_K_:_m1_b2_]" )

	if( we_are_going_to_crash <= 0 ) :

		UIFUNC_button_position_s2d_n_of_n( m1_b1 , 1 , 2 )
		UIFUNC_button_position_s2d_n_of_n( m1_b2 , 2 , 2 )

func UIFUNC_show_correct_sub_menu_based_on_global_menu_state_enumeration( ) : 
	var s0_w1_l2 =( n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 )
	if( 0 == s0_w1_l2 ) : UIFUNC_show_menu_start( )
	if( 1 == s0_w1_l2 ) : UIFUNC_show_menu_win( )
	if( 2 == s0_w1_l2 ) : UIFUNC_show_menu_lose( )


func UIFUNC_get_client_area( ) :
	var client_area : Vector2i = n2d_world.SCREENCODE_bug_cant_get_real_client_area_size( )
	return client_area
	
func UIFUNC_show_menu( ) :
	self.visible = true
	UIFUNC_show_correct_sub_menu_based_on_global_menu_state_enumeration( )
	
func UIFUNC_hide_menu( ):
	self.visible = false 
	
func UIFUNC_hide_all_sub_menus( ) :
	$N2D_MENU_START.visible = false
	$N2D_MENU_WIN  .visible = false
	$N2D_MENU_LOSE .visible = false
	
func UIFUNC_show_menu_start( ) :
	UIFUNC_hide_all_sub_menus()
	self.visible = true 
	$N2D_MENU_START.visible = true

func UIFUNC_show_menu_win( ) :
	UIFUNC_hide_all_sub_menus()
	self.visible = true 
	$N2D_MENU_WIN.visible = true

func UIFUNC_show_menu_lose( ) :
	UIFUNC_hide_all_sub_menus()
	self.visible = true 
	$N2D_MENU_LOSE.visible = true
	
	
func _physics_process( _delta ) :
	var cliarea = UIFUNC_get_client_area() 
	$COLOREC_UI.size.x =( cliarea.x )
	$COLOREC_UI.size.y =( cliarea.y )
	UIFUNC_update_control_positions( )
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

## $_BAD_MENUS_$ ###############################################
##                                                            ##
##  The file we are in was created on[ JBI_027 ].             ##
##  AKA : JAN_16TH_2024 .                                     ##
##                                                            ##
##  We aren't going to use a normal menu system I think...    ##
##  Because I don't know what I am doing , but reading        ##
##  up on how to do this right the next time.                 ##
##                                                            ##
##  Hey , as long as it ends up LOOKING RIGHT                 ##
##  then it IS RIGHT .                                        ##
##                                                            ##
############################################### $_BAD_MENUS_$ ##
