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

	var btn_wid =( btn.get_size().x )
	var btn_hig =( btn.get_size().y )

	btn.position.x =( ( cliarea.x / 2 ) - (btn_wid/2) )
	btn.position.y =( ( cliarea.y / 2 ) - (btn_hig/2) )
		
	if( 2 == tot ) :
		if( 1 == num ) : btn.position.y -=( 64 )  ######################## 
		if( 2 == num ) : btn.position.y +=( 64 )  ######################## 

	else :
		ERR( "[_ONLY_HANDLING_2_BUTTONS_PER_MENU_RIGHT_NOW_]" )
	pass

func UIFUNC_create_label_array( ) :

	var m1_l1 =( $N2D_MENU_START/LAB_BIZ_DAN )
	var m2_l1 =( $N2D_MENU_WIN/LAB_HOORAY    )
	var m3_l1 =( $N2D_MENU_LOSE/LAB_WHOOPS   )

	var lab_arr =[

		m1_l1   ## Menu #1 , label #1
	,   m2_l1   ## Menu #2 , label #1
	,   m3_l1   ## Menu #3 , label #1

	]

	return( lab_arr )

func UIFUNC_create_button_array( ) :

	var m1_b1 =( $N2D_MENU_START/BTN_MAIN_START   ) ## Menu1_Button1 ## [ JBI_028 ][ JBI_028 ]
	var m1_b2 =( $N2D_MENU_START/BTN_MAIN_QUIT    ) ## Menu1_Button2 ## [ JBI_028 ][ JBI_028 ]
																	## [ JBI_028 ][ _______ ]
	var m2_b1 =( $N2D_MENU_WIN/BTN_WIN_RESTART    ) ## Menu2_Button1 ## [ JBI_028 ][ _______ ]
	var m2_b2 =( $N2D_MENU_WIN/BTN_WIN_QUIT       ) ## Menu2_Button2 ## [ JBI_028 ][ _______ ]
																	## [ JBI_028 ][ _______ ]
	var m3_b1 =( $N2D_MENU_LOSE/BTN_LOSE_RESTART  ) ## Menu3_Button1 ## [ JBI_028 ][ _______ ]
	var m3_b2 =( $N2D_MENU_LOSE/BTN_LOSE_QUIT     ) ## Menu3_Button2 ## [ JBI_028 ][ _______ ]

	var btn_arr =[

		m1_b1
	,   m1_b2

	,   m2_b1
	,   m2_b2

	,   m3_b1
	,   m3_b2
	]
	return( btn_arr )




func UIFUNC_uniform_button_size( ) :
		
	## Try to make all buttons the exact same width by  ########
	## going though all buttons and re-sizing them all  ########
	## to the largest button size found .               ########

	var btn_arr = UIFUNC_create_button_array( )

	for _b_ in range( 0 , ( btn_arr.size()+0x0 ) , 1 )  :

		btn_arr[_b_].set_size( Vector2( 128 , 32 ) )
		btn_arr[_b_].set_icon_alignment( HORIZONTAL_ALIGNMENT_CENTER  )
		pass

	pass

func UIFUNC_size_and_position_the_label_text() :

	var lab_arr = UIFUNC_create_label_array( )
	var cliarea = UIFUNC_get_client_area() 
	var lab_set =( null ) ## label settings ##
	var labfont =( null )

	var lab_obj =( null )
	var lab_wid =( 0 )
	var lab_hig =( 0 )

	var EIGHT_PIXEL_HACK =( 8 ) 


	for _l_ in range( 0 , ( lab_arr.size()+0x0 ) , 1 )  :
		pass
		lab_obj =( lab_arr[_l_] )
		lab_arr[_l_].set_size( Vector2( 128 , 32 ) )
		lab_set = lab_arr[_l_].get_label_settings()
		## labfont = lab_arr[_l_].get_font()
		if( null != lab_set ) :
			lab_set.set_font_size( 64 )
		else :
			MSG( "[_WTF_LABEL_SETTING_NIL_]" )

		lab_wid =( lab_obj.get_size().x )
		lab_hig =( lab_obj.get_size().y )
		
		lab_obj.position.x =( cliarea.x / 2 )-( lab_wid/2 )
		lab_obj.position.y =( cliarea.y / 2 )-( lab_hig/2 )-( EIGHT_PIXEL_HACK ) ## [ JBI_028 ]

		## lab_obj.position.x =( cliarea.x / 2 )-( lab_wid/2 )
		## lab_obj.position.y =( cliarea.y / 2 )-(     0     )

	pass

func UIFUNC_update_control_positions() :

	## var m1_b1 =( $N2D_MENU_START/$BTN_MENU_START ) ## Menu1_Button1
	## var m1_b2 =( $N2D_MENU_START/$BTN_MENU_QUIT  ) ## Menu1_Button2

	## var m1_b1 =( self.N2D_MENU_START.BTN_MENU_START )
	## var m1_b2 =( self.N2D_MENU_START.BTN_MENU_QUIT  )

	var m1_b1 =( $N2D_MENU_START/BTN_MAIN_START   ) ## Menu1_Button1 ## [ JBI_028 ][ JBI_028 ]
	var m1_b2 =( $N2D_MENU_START/BTN_MAIN_QUIT    ) ## Menu1_Button2 ## [ JBI_028 ][ JBI_028 ]
																	 ## [ JBI_028 ][ _______ ]
	var m2_b1 =( $N2D_MENU_WIN/BTN_WIN_RESTART    ) ## Menu2_Button1 ## [ JBI_028 ][ _______ ]
	var m2_b2 =( $N2D_MENU_WIN/BTN_WIN_QUIT       ) ## Menu2_Button2 ## [ JBI_028 ][ _______ ]
																	 ## [ JBI_028 ][ _______ ]
	var m3_b1 =( $N2D_MENU_LOSE/BTN_LOSE_RESTART  ) ## Menu3_Button1 ## [ JBI_028 ][ _______ ]
	var m3_b2 =( $N2D_MENU_LOSE/BTN_LOSE_QUIT     ) ## Menu3_Button2 ## [ JBI_028 ][ _______ ]

	if( null == m1_b1 ) : ERR( "[_NIL_:_m1_b1_]" )
	if( null == m1_b2 ) : ERR( "[_NIL_:_m1_b2_]" )

	## if( null != m1_b1 ) : MSG( "[_O_K_:_m1_b1_]" )
	## if( null != m1_b2 ) : MSG( "[_O_K_:_m1_b2_]" )

	if( we_are_going_to_crash <= 0 ) :

		UIFUNC_uniform_button_size( )
		UIFUNC_size_and_position_the_label_text()

		UIFUNC_button_position_s2d_n_of_n( m1_b1 , 1 , 2 ) ##<<< [ JBI_029 ][ JBI_028 ]
		UIFUNC_button_position_s2d_n_of_n( m1_b2 , 2 , 2 ) ##<<< [ JBI_029 ][ JBI_028 ]
														   ##<<< [ JBI_029 ][ _______ ]
		UIFUNC_button_position_s2d_n_of_n( m2_b1 , 1 , 2 ) ##<<< [ JBI_029 ][ _______ ]
		UIFUNC_button_position_s2d_n_of_n( m2_b2 , 2 , 2 ) ##<<< [ JBI_029 ][ _______ ]
														   ##<<< [ JBI_029 ][ _______ ]
		UIFUNC_button_position_s2d_n_of_n( m3_b1 , 1 , 2 ) ##<<< [ JBI_029 ][ _______ ]
		UIFUNC_button_position_s2d_n_of_n( m3_b2 , 2 , 2 ) ##<<< [ JBI_029 ][ _______ ]

		

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

	## HACK : Force the game state to be in menu mode :         ## [ JBI_029 ]
	n2d_world    .WORLDDATA_splash_0_menu_1_game_2 =( 1 )       ## [ JBI_029 ]
	if( n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 != 0      ## [ JBI_029 ]
	&&  n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 != 1      ## [ JBI_029 ]
	&&  n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 != 2      ## [ JBI_029 ]
	):  n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 =( 0 )    ## [ JBI_029 ]

	
func UIFUNC_hide_menu( ):
	self.visible = false 
	
func UIFUNC_hide_all_sub_menus( ) :
	$N2D_MENU_START.visible = false
	$N2D_MENU_WIN  .visible = false
	$N2D_MENU_LOSE .visible = false
	
func UIFUNC_show_menu_start( ) :
	n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 =( 0 ) ############ [ JBI_029 ]
	n2d_world.WORLDDATA_splash_0_menu_1_game_2    =( 1 ) ############ [ JBI_029 ]SHOWING_MENU_CHANGES_GAME_MODE
	UIFUNC_hide_all_sub_menus()
	self.visible = true 
	$N2D_MENU_START.visible = true

func UIFUNC_show_menu_win( ) :
	n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 =( 1 ) ############ [ JBI_029 ]
	n2d_world.WORLDDATA_splash_0_menu_1_game_2    =( 1 ) ############ [ JBI_029 ]SHOWING_MENU_CHANGES_GAME_MODE
	UIFUNC_hide_all_sub_menus()
	self.visible = true 
	$N2D_MENU_WIN.visible = true

func UIFUNC_show_menu_lose( ) :
	n2d_world.WORLDDATA_menu_start_0_win_1_lose_2 =( 2 ) ############ [ JBI_029 ]
	n2d_world.WORLDDATA_splash_0_menu_1_game_2    =( 1 ) ############ [ JBI_029 ]SHOWING_MENU_CHANGES_GAME_MODE
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


func _on_btn_main_start_pressed():
	MSG( "[_BTN_MAIN_START_]")
	pass # Replace with function body.
func _on_btn_main_quit_pressed():
	MSG( "[_BTN_MAIN_QUIT_]" )
	pass # Replace with function body.

func _on_btn_win_restart_pressed():
	MSG( "[_BTN_WIN_RESTART_]")
	pass # Replace with function body.
func _on_btn_win_quit_pressed():
	MSG("[_BTN_WIN_QUIT_]")
	pass # Replace with function body.

func _on_btn_lose_restart_pressed():
	MSG( "[_BTN_LOSE_RESTART_]" )
	pass # Replace with function body.
func _on_btn_lose_quit_pressed():
	MSG( "[_BTN_LOSE_QUIT_]" )
	pass # Replace with function body.
