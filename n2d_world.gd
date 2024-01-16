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

var   WORLDDATA_psr_ui : PackedScene = preload( "res://NOD/n2d_ui.tscn" ) ## [ JBI_027 ]
var   WORLDDATA_n2d_ui : Node2D      =( null )                            ## [ JBI_027 ]
var   WORLDDATA_has_ui : int         =(  0   )                            ## [ JBI_027 ]

var   WORLDDATA_psr_client_area : PackedScene   =preload( "res://NOD/rec_client_area.tscn" )
var   WORLDDATA_rec_client_area : ReferenceRect =( null )
var   WORLDDATA_has_client_area : int           =(  0   )

var   WORLDDATA_are_we_on_the_opening_screen : int =( 1 )
var   WORLDDATA_s2d_flag_frame_f32 =( 0.0 )
var   WORLDDATA_s2d_flag_frame_i32 =( 0-1 )

const WORLDDATA_increment_score_display_cooldown  : String = "[ YOU MEAN : LEVEL NUMBER NOT SCORE ]"
var   WORLDDATA_increment_level_display_cooldown  : int =(  0  )


var WORLDDATA_has_dan_hit_the_hay_this_level    : int   =(  0  )
var WORLDDATA_invincible_grace_period_countdown : int   =(  0  )
var WORLDDATA_hay_hill_spawn_percent_marker     : float =( 0.0 )


##################################### WE_CAN_SORT_THIS_LATER ###
### MORE_WORLD_DATA ############################################################

var     WORLDDATA_hay_cooldown         = 0
const   WORLDDATA_hay_cool_it          = "[ USE : WORLDDATA_hay_cooldown ]"

var   WORLDDATA_level                = 1  ## Starting level is 1 ##
const WORLDDATA_current_level_number = "[ USE : WORLDDATA_level ]"
const WORLDDATA_level_number         = "[ USE : WORLDDATA_level ]"

var WORLDDATA_dan_should_fall_down_screen_now : bool = false

var WORLDDATA_has_flag : int =( 0 )
var WORLDDATA_s2d_flag : Sprite2D = null
var WORLDDATA_psr_flag : PackedScene = preload( "res://NOD/s2d_flag.tscn" )

var WORLDDATA_has_hay : bool = false 
var WORLDDATA_s2d_hay : Sprite2D = null 
var WORLDDATA_hay_is_visible : int =( 0 )

var WORLDDATA_has_hil : bool = false    ## NOT[ WORLDDATA_s2d_hil_has ]
var WORLDDATA_s2d_hil : Sprite2D = null 
var WORLDDATA_hil_is_visible : int =( 0 )

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
var DANDATA_m2d_dan : Marker2D = null

############################################################## FUCKING_HACKS ###
### MAINCODE ##################################################--###############

@onready var nod_configcode = get_node( "NOD_CONFIGCODE" )
@onready var nod_cloudcode  = get_node( "NOD_CLOUDCODE"  )
@onready var nod_birdcode   = get_node( "NOD_BIRDCODE"   )
@onready var nod_spawncode  = get_node( "NOD_SPAWNER"    )
@onready var nod_dancode    = get_node( "NOD_DANCODE"    )
######## var n2d_ui         = get_node( "N2D_UI"         ) <<<<< WRONG , NOT PART OF SCENE , instantiated

var WORLDDATA_has_process_been_hit_at_least_once : int =( 0 )


func  WORLDFUNC_win_level( ) :
	WORLDDATA_level +=( 1 )
	WORLDCODE_reset_and_start_level( )
	pass

func  WORLDFUNC_you_died( ) :
	print( "[_WORLD_CODE_YOU_DIED_]" )
	WORLDDATA_level =( 1 ) ## Back To Level One You Fucking Loser ##
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

var WORLDDATA_psr_level_number     : PackedScene = preload( "res://NOD/lab_level_number.tscn" )
var WORLDDATA_psr_m2d_level_number : PackedScene = preload( "res://NOD/m2d_level_number.tscn" )
var WORLDDATA_psr_rec_level_number : PackedScene = preload( "res://NOD/rec_level_number.tscn" )

var WORLDDATA_psr_background : PackedScene = preload( "res://s2d_background.tscn" )
var WORLDDATA_psr_foreground : PackedScene = preload( "res://s2d_fg.tscn"         )

var WORLDDATA_lab_level_number : Label         = null
var WORLDDATA_m2d_level_number : Marker2D      = null 
var WORLDDATA_rec_level_number : ReferenceRect = null

var WORLDDATA_s2d_background : Sprite2D = null 
var WORLDDATA_s2d_background_count : int =( 0 )

var WORLDDATA_s2d_foreground : Sprite2D = null 
var WORLDDATA_s2d_foreground_count : int =( 0 )

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
### rec_screen_area    : Rect2i    ### @rec@ : Rectangle    ###
var iv2_client_size    : Vector2i  ### Client Area Of Window For Bug Fixing [ JBI_021 ] ##
pass
var SCREENCODE_full_screen_cooldown : int =( 0 )
pass
###############--################################################ SCREENCODE ###
### WORLDFUNC #################################################--###############


func WORLDFUNC_err( i_err_msg : String ) :
	print( "[_WORLDFUNC_ERROR_]:" , i_err_msg )
	get_tree().quit() ## AKA : exit ##
	pass
func ERR( i_err_msg : String ) :
	print( "[_WORLDFUNC_ERR_]:" , i_err_msg )
	get_tree().quit() ## AKA : exit ##
	pass

func MSG( i_msg : String ) :
	print( "[ n2d_world.gd ]:" , i_msg )
	pass


func WORLDFUNC_calc_level_number_font_size( ) :

	var o_fontsiz : int =( 512 )

	return( o_fontsiz ) 
	pass

func WORLDFUNC_calc_and_store_game_duration_in_ticks( ) :

	## When we use our debug to skip to end of game ,         ##
	## will we need to re-calculate this ? I don't think so . ##

	var fps =( 60 )
	var minutes = nod_configcode.CONFIGDATA_game_duration_in_minutes
	WORLDDATA_game_duration_in_ticks =int( minutes * 60 * fps )

##   DEBUGFUNC_increment_level_number_and_update_display
func DEBUGFUNC_increment_level_number( ) :
	
	WORLDDATA_level +=( 1 )
	WORLDFUNC_update_level_number_text( )
	pass
##  
##   DEBUGFUNC_update_level_number_display_keep_level_number_same( ) :
func DEBUGFUNC_update_level_number_centering( ) : 
	
	WORLDFUNC_update_level_number_value( )
	pass

func WORLDFUNC_update_level_number_text( ) :

	## ONLY UPDATE THE TEXT ! NOT THE CENTERING CODE  ##

	WORLDDATA_lab_level_number.text =( str( WORLDDATA_level ) )
	if( WORLDDATA_lab_level_number.text.length() < 2 ) :
		WORLDDATA_lab_level_number.text =(
		"0" +
		WORLDDATA_lab_level_number.text
	)
	
func WORLDFUNC_make_that_number_fucking_huge ( ) :

	## Why am I getting fucked because I[ RTFM ]. ###################
	## ERROR : Invalid get index 'font_size' ( on base : 'Label' ) ##
	## <Label>.get_label_settings( ) <-- DOESNT ACTUALLY FUCKING EXIST EVEN THOUGH IN DOCUMENTATION
	## https://docs.godotengine.org/en/stable/classes/class_label.html
	
	var fontsiz : int = WORLDFUNC_calc_level_number_font_size()
	
	var lab_obj : Label = ( WORLDDATA_lab_level_number )
	var labthem : Theme = lab_obj.theme
	var lab_set : LabelSettings = lab_obj.label_settings
	if( null == labthem ):
		MSG( "[_FUCKING_NULL_THEME_]" )
	else :
		MSG( "[_HOW_DO_I_USE_SET_FONT_SIZE_]" )
		labthem.set_default_font_size( fontsiz )
		## labthem.set_font_size( )
		
	if( null == lab_set ):
		MSG( "[_WHAT_THE_FUCKING_HELL_NULL_LABEL_SETTINGS_]")
	else :
		pass
		## lab_set.font_size =( fontsiz )

func WORLDFUNC_center_the_fucking_number( ) :

	## THIS IS THE CORE CODE FUCKING UP OUR DAY . FIX IT! ##<<<< [ JBI_025 ]

	## For this to work , you need the correct settings ####
	## on your label , see this imgur post #################
	## IMGUR[ https://imgur.com/bSf8DaN ]
	## SUDO_CODE : <label>.Control.Anchor_Presets =[ Full_Rect ]
	
	var lab_obj : Label         = ( WORLDDATA_lab_level_number )
	var m2d_obj : Marker2D      = ( WORLDDATA_m2d_level_number )
	var rec_obj : ReferenceRect = ( WORLDDATA_rec_level_number )

	## var client_area : Vector2i = DisplayServer.window_get_size( 0 )
	var client_area : Vector2i = SCREENCODE_bug_cant_get_real_client_area_size()
	var sceen_center_x =( client_area.x / 2 )
	var sceen_center_y =( client_area.y / 2 )

	lab_obj.vertical_alignment   =   VERTICAL_ALIGNMENT_CENTER  ##### [ JBI_025 ]
	lab_obj.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER  ##### [ JBI_025 ]

	## lab_obj.vertical_alignment   =   VERTICAL_ALIGNMENT_TOP     ##### [ JBI_025 ]
	## lab_obj.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT    ##### [ JBI_025 ]

	## lab_obj.size.x =( 400 ) 
	## lab_obj.size.y =( 0 ) 


	lab_obj.position.x =( sceen_center_x ) ## $_P_TWICE_$ ##
	lab_obj.position.y =( sceen_center_y ) ## $_P_TWICE_$ ##

	lab_obj.position.x =( sceen_center_x ) ## $_P_TWICE_$ ##
	lab_obj.position.y =( sceen_center_y ) ## $_P_TWICE_$ ##

	## BUG_IN_GODOT_001 ########################################
	##                                                        ##
	##  When the game starts up all you need to use is :      ##
	##                                                        ##
	##  lab_obj.position.x =( sceen_center_x )                ##
	##  lab_obj.position.y =( sceen_center_y )                ##
	##                                                        ##
	##  To correctly center the object .                      ##
	##  But later you need to subtract half the width         ##
	##  and height of the object to center it ...             ##
	##  Its like the[ Anchors_Preset ]just create more        ##
	##  problems than they solve and maybe they should always ##
	##  be set to[ TOP_LEFT ]if you want to avoid headaches   ##
	##--------------------------------------------------------##

	var lab_wid : int =( lab_obj.size.x )  ## [ JBI_025 ]
	var lab_hig : int =( lab_obj.size.y )  ## [ JBI_025 ]
	lab_obj.position.x =( sceen_center_x - ( lab_wid / 2 ) )  
	lab_obj.position.y =( sceen_center_y - ( lab_hig / 2 ) ) 

	######################################## BUG_IN_GODOT_001 ##

	m2d_obj.position.x =( sceen_center_x ) ## DUMMY_PIVOT ##
	m2d_obj.position.y =( sceen_center_y ) ## DUMMY_PIVOT ##

	rec_obj.position.x =( sceen_center_x ) ## DUMMY_RECTA ##
	rec_obj.position.y =( sceen_center_y ) ## DUMMY_RECTA ##

	########################################################
	##                                                    ##
	##  Seeing : [ 576 , 324 ] each time .                ##
	##  This is confirming my suspicion that for some     ##
	##  reason the anchor point of the label is getting   ##
	##  reset somehow . Either being triggered by :       ##
	##                                                    ##
	##  Start checking off possibilities :                ##
	##                                                    ##
	##  _Y/N_ 1. Screen resize code resetting anchor points
	##  __N__ 2. Setting .position twice resets anchors   ##
	##  _Y/N_ 3. Something else                           ##
	##                                                    ##
	########################################################
	print( "[_LAB_OBJ_._POS_._X_]:" , lab_obj.position.x );
	print( "[_LAB_OBJ_._POS_._Y_]:" , lab_obj.position.y );


func WORLDFUNC_update_level_number_value( ) :

	##__ON_SCREEN_LEVEL_NUMBER_COUNTER__########################
	##             TAG[ LEVEL_NUMBER_AS_BACKGROUND_ELEMENT ? ]##
	##             TAG[ $_LEVEL_NUMBER_AS_BG_ELEMENT_$       ]##
	##             TAG[ $_LEVEL_NUMBER_BG_$                  ]##

	if( null == WORLDDATA_lab_level_number ) :
		WORLDDATA_lab_level_number =( WORLDDATA_psr_level_number.instantiate() )
		WORLDDATA_n2d_world.add_child( WORLDDATA_lab_level_number )

	if( null == WORLDDATA_m2d_level_number ) :
		WORLDDATA_m2d_level_number =( WORLDDATA_psr_m2d_level_number.instantiate() )
		WORLDDATA_n2d_world.add_child( WORLDDATA_m2d_level_number )
		########################################################
		##                                                    ##
		##  JBI_025 : The[ Marker2D ]is not showing up on     ##
		##          : screen , yet we are in debug mode .     ##
		##          : Is it an option like how we had to      ##
		##          : make collision boxes visible ?          ##
		##                                                    ##
		##  THE_ANSWER_MAY_PISS_YOU_OFF[ imgur.com/a/dJ7aq9S ]##
		##                                                    ##
		########################################################

	if( null == WORLDDATA_rec_level_number ) :
		WORLDDATA_rec_level_number =( WORLDDATA_psr_rec_level_number.instantiate() )
		WORLDDATA_n2d_world.add_child( WORLDDATA_rec_level_number )
	
	if( true ) : ## PUT_CORRECT_NUMBER : VVVVVVVVVVVVVVVVVVVV ##

		WORLDFUNC_update_level_number_text( )

	if( true ) : ## Make that number fucking huge !!!!!!!!!!! ##
	
		WORLDFUNC_make_that_number_fucking_huge ( )
		
	if( true ) : ## CENTER THE FUCKING NUMBER 

		WORLDFUNC_center_the_fucking_number( )



	########################__ON_SCREEN_LEVEL_NUMBER_COUNTER__##

func WORLDFUNC_make_sure_client_area_reference_rect_exists( ) :                      ## [ JBI_027 ] ##
																					 ## [ JBI_027 ] ##
		if( WORLDDATA_has_client_area <= 0 ) :                                       ## [ JBI_027 ] ##
			WORLDDATA_has_client_area =( 1 )                                         ## [ JBI_027 ] ##
			if( WORLDDATA_rec_client_area != null ) : ERR( "[_MEOWMIX_]" )           ## [ JBI_027 ] ##
			WORLDDATA_rec_client_area =( WORLDDATA_psr_client_area.instantiate() )   ## [ JBI_027 ] ##
			WORLDDATA_n2d_world.add_child( WORLDDATA_rec_client_area )               ## [ JBI_027 ] ##

func WORLDFUNC_make_sure_ui_container_exists( ) :

	if( WORLDDATA_has_ui <= 0 ) :
		WORLDDATA_has_ui =( 1 )
		if( WORLDDATA_n2d_ui != null ) : ERR( "[_UI_CONTAINER_ALREADY_EXIST_]" )
		WORLDDATA_n2d_ui = ( WORLDDATA_psr_ui.instantiate() )
		WORLDDATA_n2d_world.add_child( WORLDDATA_n2d_ui )  

func WORLDFUNC_INI():

	WORLDDATA_game_time_in_ticks =( 0 )
	WORLDDATA_has_dan_hit_the_hay_this_level =( 0 )

	## HACK[ KEEP_DAN_IN_FRONT_HACK / JBI_023 ]#################
	WORLDFUNC_hay_hide( ) ## Hide hay stack at start of game ###
	WORLDFUNC_hil_hide( ) ## Hide the foreground hills       ###

	if( nod_configcode.CONFIGDATA_start_with_3_seconds_left ) :
		nod_configcode.CONFIGDATA_game_duration_in_minutes =( 3.0/60.0 )
		
	WORLDFUNC_calc_and_store_game_duration_in_ticks( )

	##__REFACTORED_INTO_READY__#################################

	if( null == WORLDDATA_s2d_background ):
		WORLDDATA_s2d_background = WORLDDATA_psr_background.instantiate()
		WORLDDATA_n2d_world.add_child( WORLDDATA_s2d_background )
		WORLDDATA_s2d_background_count +=( 1 )
		if( WORLDDATA_s2d_background_count > 1 ) :
			WORLDFUNC_err( "[_TOO_MANY_BACKGROUNDS_]" )
		pass
	pass

	### JBI_021 ################################################
	##                                                        ##
	##  We need a foreground layer that is at the same        ##
	##  depth as the player to fix a problem with the game.   ##
	##  With only one background image , that image ends up   ##
	##  becomming the foreground at the end of the game ,     ##
	##  causing problems for us .                             ##
	##                                                        ##
	##  We want the background to scroll SLOWER than the      ##
	##  foreground . But the HAYSTACK is in the foreground    ##
	##  and needs to be moving at the same speed as the       ##
	##  earth behind it .                                     ##
	##                                                        ##
	############################################################

	### if( null == WORLDDATA_s2d_foreground ):
	### 	WORLDDATA_s2d_foreground = WORLDDATA_psr_foreground.instantiate()
	### 	WORLDDATA_n2d_world.add_child( WORLDDATA_s2d_foreground )
	### 	WORLDDATA_s2d_foreground_count +=( 1 )
	### 	if( WORLDDATA_s2d_foreground_count > 1 ) :
	### 		WORLDFUNC_err( "[_TOO_MANY_FOREGROUNDS_]" )
	### 	pass
	### 
	### 	### JBI_021 ############################################
	### 	## TEMPORARY HACK TO SEE TRANPARENCY AT TOP :
	### 	### fg_wid : float = WORLDDATA_s2d_foreground.texture.get_width()
	### 	var fg_hig : float = WORLDDATA_s2d_foreground.texture.get_height()
	### 	WORLDDATA_s2d_foreground.position.y =( fg_hig / 2 )
	### 	############################################ JBI_021 ###
	### 
	### pass

	################################################ JBI_021 ### 

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
	
	## This works the first time , but when the level      #####
	## resets , the text is no longer fucking centered !!! #####
	WORLDFUNC_update_level_number_value( ) ## <-- $_IDEMPOTENT_$
	WORLDFUNC_update_level_number_value( ) ## <-- $_IDEMPOTENT_$

	##__HILL_HAY_HACK__#########################################
	##__   JBI_022   __#########################################

	## Show and hide the hill upon game initialization
	## so that the hill remains behind stuff .
	WORLDFUNC_hil_show()
	WORLDFUNC_hil_hide()

	WORLDDATA_dan_should_fall_down_screen_now = false 

	#########################################__   JBI_022   __##
	#########################################__HILL_HAY_HACK__##

	WORLDFUNC_make_sure_client_area_reference_rect_exists() #### <<<[ JBI_027 ]
	WORLDFUNC_make_sure_ui_container_exists() ################## <<<[ JBI_027 ]
	
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
		WORLDDATA_n2d_world.add_child( WORLDDATA_s2d_hay )
	if( 0 == WORLDDATA_hay_is_visible ) :
		WORLDDATA_hay_is_visible  =( 1 )
		WORLDDATA_s2d_hay.visible = true 
		pass
	if( true ) :
		## OOOPS ! We want this in "hill show" not "hay show"
		## WORLDFUNC_update_world_object_scales( )
		pass
	if( true ) : 

		## ALWAYS ADJUST WHERE HAY IS WHEN SHOWING IT TO
		## MAKE SURE IT IS IN CORRECT POSITION 
		var client_area : Vector2i = DisplayServer.window_get_size( 0 )
		var hay_hig : float = WORLDDATA_s2d_hay.texture.get_height()
		WORLDDATA_s2d_hay.position.x =( client_area.x / 2 )
		WORLDDATA_s2d_hay.position.y =( client_area.y - (hay_hig/2) )


func WORLDFUNC_put_dan_in_front_of_display_list( ) :
	## How about we try[ add_child_below_node() ]when adding the hills and hay ? ##
	pass

func WORLDFUNC_hil_hide() : ## Foreground Hills BG Hide ##
	if( false == WORLDDATA_has_hil ) :
		pass ## do nothing
	if( true  == WORLDDATA_has_hil ) :
		WORLDDATA_hil_is_visible =( 0 )
		WORLDDATA_s2d_hil.visible = false
	pass

func WORLDFUNC_hil_show() : ## Foreground Hills BG Show ##

	## COPY_PASTE_REFACTOR_OF[ WORLDFUNC_hay_show ]#############

	###################################################
	##  HACKISH GLUE CODE BECAUSE I AM LAZY AND DONT ##
	##  WANT TO REFACTOR NAMES AND SHIT              ##
	###################################################
	var WORLDDATA_psr_hil = WORLDDATA_psr_foreground

	var first_time_showing_the_hay =( 0 )

	if( false == WORLDDATA_has_hil ) :
		WORLDDATA_s2d_hil = WORLDDATA_psr_hil.instantiate()
		WORLDDATA_has_hil = true
		WORLDDATA_n2d_world.add_child( WORLDDATA_s2d_hil )
	##  WORLDDATA_n2d_world.add_child_below_node( <<<<<<<<<<<<<<<<< NOT A REAL COMMAND ?
	##  	  WORLDDATA_s2d_hil
	##  ,     DANDATA_s2d_dan
	##  )

	if( 0 == WORLDDATA_hil_is_visible ) :
		first_time_showing_the_hay=( 1 )
		WORLDDATA_hil_is_visible  =( 1 )
		WORLDDATA_s2d_hil.visible = true 
		pass

	## Set initial position of the hay ##
	if( first_time_showing_the_hay ) :   
		if( true ) :
			## Force update of hills background ##
			WORLDFUNC_update_world_object_scales( )

		if( true ) : 
			## ALWAYS ADJUST WHERE HIL IS WHEN SHOWING IT TO
			## MAKE SURE IT IS IN CORRECT POSITION 
			var client_area : Vector2i = DisplayServer.window_get_size( 0 )
			var hil_hig : float = WORLDDATA_s2d_hil.texture.get_height()

			## Position Hill Directly Off Screen Bottom Screen #####
			var hig_hil =( hil_hig * WORLDDATA_background_scale )
			WORLDDATA_s2d_hil.position.x =( client_area.x / 2 )
			WORLDDATA_s2d_hil.position.y =( client_area.y + (hig_hil/2) )

	## Make sure dan is in front of everything #################
	WORLDFUNC_put_dan_in_front_of_display_list()

##------------------------------------------------------------##

func WORLDFUNC_process_physics_hill_and_hay_position() :

	WORLDDATA_s2d_hil.position.y -=( nod_configcode.CONFIGDATA_fall_speed_in_pixels_per_frame_at_60fps )
	
	if( true ) : ## cap update position to tangent bottom edge of screen 

			var client_area : Vector2i = DisplayServer.window_get_size( 0 )
			var hil_hig : float = WORLDDATA_s2d_hil.texture.get_height()
			var hig_hil =( hil_hig * WORLDDATA_background_scale )
			var hil_tan =( client_area.y - (hig_hil/2) )

			if( WORLDDATA_s2d_hil.position.y < hil_tan ):
				WORLDDATA_s2d_hil.position.y = hil_tan
				## HACK : The physical position of the foreground is 
				##      : what we use to trigger dan falling .
				WORLDDATA_dan_should_fall_down_screen_now = true 
	pass

##------------------------------------------------------------##

func WORLDFUNC_adjust_foreground_bg_scroll_based_on_game_time( ) :
	
	############################################################
	##                                                        ##
	##  Tricky , I want the position of this background to    ##
	##  be a strict function of the game ticker timer .       ##
	##                                                        ##
	##  BUT !!! I want it to move up screen at the same       ##
	##  speed that all of the geese and clouds move .         ##
	##                                                        ##
	##  We have some math to do !                             ##
	##                                                        ##
	##  Okay... So that is hard... And not how the game       ##
	##  is setup ...                                          ##
	##                                                        ##
	##  Just create a[ WROLDFUNC_foreground_hills_show ]      ##
	##                                                        ##
	############################################################

	pass    ## NOT USE THIS FUNCTION .                        ##  
			## 1 . MATH IS TOO HARD                           ##                            
			## 2 . PROJECT STRUCTURE IS SHIT AND IF WE REALLY ##
			##     WANTED TO DO IT THIS WAY WE SHOULD HAVE    ##
			##     [ WATERFALLED / DESIGNED ]IT INTO OUR PLANS##
			##     BETTER FROM THE BEGINNING                  ##


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

	WORLDFUNC_hil_show() ## Show the foreground hills ##############
	WORLDFUNC_hay_show() ## Show the hay , but animate into frame ##

	WORLDFUNC_process_physics_hill_and_hay_position()

	pass

func WORLDFUNC_calculate_spawn_time_percent_for_hay_and_hill( ) :
	
	## TAG[ CALC_FG_HILL_SPAWN_TIME / JBI_023 ]#################

	## HARDCODE UNTIL WE CAN DO PROPER CALCULATIONS ##
	WORLDDATA_hay_hill_spawn_percent_marker = 0.9   

	## PROBLEM : The game lasts a certain duration in ticks .
	##         : We want to spawn the hill at just the right
	##         : moment, so that the[ HILL / FG ]stops
	##         : scrolling at the same time as the[ BACKGROUND ]
	
	var ppt : float ## Scroll speed of everyting in terms of
					## "pixels_per_tick"

	var hip : float ## Height of foreground image in pixels
					## after applying scale to the texture 

	var hif : float ## Height of frogeround image in FRAMES .
					## as in , how many frames does it take
					## the foreground_hills to scroll it's
					## entire height at given scroll speed
					## in pixels_per_tik( ppt ) ?

	var gdf : int   ## @gdf@ : Game_Duration_Frames , the
					## duration of the game in frames .

	var hsf : int   ## @hsf@ : hill spawn frame , take the 
					## duration of game in ticks and subtract
					## the hill's height in[ TIME/FRAMES ].

	var hsp : float ## @hsp@ : hill spawn percent , convert
					## the hill spawn frame into a hill spawn
					## percentage .

	ppt = float( nod_configcode.CONFIGDATA_fall_speed_in_pixels_per_frame_at_60fps )
	hip = ( 
			 WORLDDATA_s2d_hil.texture.get_height()
		*    WORLDDATA_background_scale 
	)
	hif = ( hip / ppt )
	gdf = ( WORLDDATA_game_duration_in_ticks )
	hsf = ( gdf - hif ) ## Hill_Spawn_Frame_Point ##
	hsp = float( hsf ) / float( gdf )

	WORLDDATA_hay_hill_spawn_percent_marker =( hsp )

func WORLDFUNC_increment_level_number_scroll_up_screen( ):

	if( null == WORLDDATA_lab_level_number ) : return
	var lab_obj : Label         = ( WORLDDATA_lab_level_number )
	var speed : int = nod_configcode.CONFIGDATA_fall_speed_in_pixels_per_frame_at_60fps
	lab_obj.position.y -=( speed / 3 )
	pass

func WORLDFUNC_center_sprite_on_screen( i_s2d : Sprite2D ) :
	var client_area : Vector2i = SCREENCODE_bug_cant_get_real_client_area_size()
	var screen_center_x =( client_area.x / 2 )
	var screen_center_y =( client_area.y / 2 )
	i_s2d.position.x =( screen_center_x )
	i_s2d.position.y =( screen_center_y )
	pass

func WORLDFUNC_scale_sprite_to_fill_screen( 

	i_s2d     : Sprite2D 
,   i_numcelx : int  ## $_NUMBER_OF_CELLS_ON_X_AXIS_$  <<<<<<<<<<<<<< [ JBI_027 ]
,   i_numcely : int  ## $_NUMBER_OF_CELLS_ON_Y_AXIS_$  <<<<<<<<<<<<<< [ JBI_027 ]
) :
	if( ! ( i_numcelx >= 1 ) ) : ERR( "[_numcel_x_]" )
	if( ! ( i_numcely >= 1 ) ) : ERR( "[_numcel_y_]" )
	pass
	pass ## TAG[ our-flag-means-fun | our_flag_means_fun  ] ##<< [ JBI_027 ]
	pass ## TAG[ ourflagmeansfun    | fill-fucking-screen ] ##<< [ JBI_027 ]
	pass
	var client_area : Vector2i = SCREENCODE_bug_cant_get_real_client_area_size()
	var cli_wid : float =( client_area.x * 1 )
	var cli_hig : float =( client_area.y * 1 )
	pass
	var s2d_wid : float =( i_s2d.texture.get_width( ) / i_numcelx )
	var s2d_hig : float =( i_s2d.texture.get_height() / i_numcely )
	pass
	var gap_wid : int =( cli_wid - s2d_wid )
	var gap_hig : int =( cli_hig - s2d_hig )
	pass
	var ska         : float =( 1.0 )
	pass
	if(   gap_wid <= gap_hig ) :  ## ( s2d_wid * ska = cli_wid )
		pass                      ## ska =( cli_wid / s2d_wid )
		ska =( cli_wid / s2d_wid )
		 
	elif( gap_hig <= gap_wid ) :  ## ( s2d_hig * ska = cli_hig )
		pass                      ## ska =( cli_hig / s2d_hig )
		ska =( cli_hig / s2d_hig )
	pass
	
	pass
	i_s2d.scale.x =( ska )
	i_s2d.scale.y =( ska )
	pass

func WORLDFUNC_process_physics_menu( ) :

	if( WORLDDATA_has_flag <= 0 ) :
		if( null != WORLDDATA_s2d_flag ) : ERR( "[_MEMORY_LEAKING_]" )
		WORLDDATA_has_flag =( 1 )
		WORLDDATA_s2d_flag =( WORLDDATA_psr_flag.instantiate() )
		WORLDDATA_n2d_world.add_child( WORLDDATA_s2d_flag )
	pass
	WORLDFUNC_center_sprite_on_screen(     WORLDDATA_s2d_flag )
	WORLDFUNC_scale_sprite_to_fill_screen( WORLDDATA_s2d_flag , 6 , 1 )
	pass
	WORLDDATA_s2d_flag_frame_f32 +=( 0.25 )
	WORLDDATA_s2d_flag_frame_i32 =( int( WORLDDATA_s2d_flag_frame_f32 ) )
	WORLDDATA_s2d_flag_frame_i32 = WORLDDATA_s2d_flag_frame_i32 % 6
	WORLDDATA_s2d_flag.frame =( WORLDDATA_s2d_flag_frame_i32 )


func WORLDFUNC_process_physics_game( ) :
	WORLDFUNC_increment_level_number_scroll_up_screen() 

	WORLDDATA_increment_level_display_cooldown -=( 1 )
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
		pass

	## We need something like this ##
	WORLDFUNC_calculate_spawn_time_percent_for_hay_and_hill()
	if( WORLDDATA_percent_scroll >= WORLDDATA_hay_hill_spawn_percent_marker ) :
		WORLDFUNC_process_physics_falltime()

	pass

func WORLDFUNC_hide_the_flag( ) :
	if( WORLDDATA_has_flag ) :
		WORLDDATA_s2d_flag.visible =( false ) 

func WORLDFUNC_show_the_flag( ) :
	if( WORLDDATA_has_flag ) :
		WORLDDATA_s2d_flag.visible =( true ) 

func WORLDFUNC_process_physics( ):

	if( WORLDDATA_are_we_on_the_opening_screen >= 1 ) :
		WORLDFUNC_show_the_flag( )
		WORLDFUNC_process_physics_menu( )
	else :
		WORLDFUNC_hide_the_flag( )
		WORLDFUNC_process_physics_game( )


func WORLDFUNC_update_world_object_scales( ) :

	var bg_wid : float = WORLDDATA_s2d_background.texture.get_width()
	var bg_hig : float = WORLDDATA_s2d_background.texture.get_height()

	### JBI_021 ################################################
	###                                                      ###
	### _WRONG_ : iv2_screen_size                            ###
	### __YES__ : iv2_client_size                            ###
	###                                                      ###
	###------------------------------------------------------###

	var vp_wid : float = iv2_client_size.x  ## JBI_021 | BUG_021 | ##
	var vp_hig : float = iv2_client_size.y  ## JBI_021 | BUG_021 | ##

	################################################ JBI_021 ###

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
	pass
	if( WORLDDATA_has_hil ) :
		## Forground hills graphic must have identical width  ##
		## to the giant scrolling background graphic for      ##
		## these two lines of code below to work              ##
		WORLDDATA_s2d_hil.scale.x =( WORLDDATA_background_scale )
		WORLDDATA_s2d_hil.scale.y =( WORLDDATA_background_scale )

##   WORLDCODE_fast_forward_to_3_seconds_left WRONG_SEE_BELOW
func WORLDFUNC_fast_forward_to_3_seconds_left( ) :
	
	############################################################
	##                                                        ##
	##  Take the game duration in ticks and subtract          ##
	##  3 seconds worth of ticks at 60FPS per second          ##
	##  to fast forward the game to having 3 seconds left     ##
	##                                                        ##
	############################################################

	var tik_cur =( WORLDDATA_game_duration_in_ticks )
	## we don't actually need "tik_cur" ....
	var tik_new =( WORLDDATA_game_duration_in_ticks - ( 3*60) )
	WORLDDATA_game_time_in_ticks =( tik_new )

	pass

###############--################################################# WORLDFUNC ###
### SCREENCODE ################################################--###############

func SCREENCODE_process( ) :
	SCREENCODE_full_screen_cooldown -=( 1 )


### JBI_021 ####################################################
###                                                          ###
### I cant seem to figure out how to get the[ CLIENT_AREA ]. ###
### So we are writing a wrapper function that returns the    ###
### [ PHYSICAL_SCREEN_SIZE ]when we fail .                   ###
###                                                          ###
### UPDATE : JBI_022 , 2024_01_06 , 12:36 AM                 ###
###        : WRONG : DisplayServer.window_get_size( a_s )    ###
###        : _YES_ : DisplayServer.window_get_size(  0  )    ###
###        : Our code now gets the correct[ client_area ].   ###
###                                    TAG[ client area ]    ###
###                                                          ###
### UPDATE : JBI_022 , 2024_01_06 , 12:29 AM                 ###
###        : This code works on my LEFT VERTICAL MONITOR ONLY###
###        : I think the "active_screen" function might      ###
###        : be broken ?                                     ###
###                                                          ###
###----------------------------------------------------------###

func SCREENCODE_bug_cant_get_real_client_area_size( ) : ## <---  [ WTF_001 ] ##

	var client_size          : Vector2i ## OUTPUT OF FUNCTION
	var active_screen        : int      = SCREENCODE_what_screen_is_my_window_on()
	var a_s                  : int      =( active_screen )
	var client_returns_0_0   : Vector2i ##
	var physical_screen_size : Vector2i ##

	if( a_s ) :
		pass  ## ACTIVE SCREEN IS PHYSICAL , IT IS NOT
			  ## THE WINDOW , WE WANT THE WINDOW.
			  ## CLIENT_AREA == window_get_size( 0 )
			  ## ZERO BECAUSE WE ONLY HAVE ONE WINDOW 
			  ## JBI_022

	client_returns_0_0 = DisplayServer.window_get_size( 0 )     ## JBI_022 && JBI_021 ##

	if( client_returns_0_0.x == 0
	||  client_returns_0_0.y == 0 
	) :
		physical_screen_size = DisplayServer.screen_get_size( a_s )
		client_size.x = physical_screen_size.x
		client_size.y = physical_screen_size.y
	else :
		client_size.x = client_returns_0_0.x
		client_size.y = client_returns_0_0.y

	## JBI_027 #################################################
	##                                                        ##
	##  Debug this client area by setting a reference         ##
	##  rectangle to the size of the client area rectangle    ##
	##  that we are returning .   DATE[ 2024_JAN_16 ]         ##
	##--------------------------------------------------------##
	if( null != WORLDDATA_rec_client_area ):
		
		WORLDDATA_rec_client_area.position.x =( 0 ) 
		WORLDDATA_rec_client_area.position.y =( 0 ) 

		WORLDDATA_rec_client_area.size.x =( client_size.x ) 
		WORLDDATA_rec_client_area.size.y =( client_size.y ) 
		
	pass
	################################################# JBI_027 ##

	return client_size  ## iv2_client_size ##

##################################################### JBI_021 ##

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
##  rec_screen_area    = DisplayServer.screen_get_usable_rect( a_s )
	iv2_client_size    = SCREENCODE_bug_cant_get_real_client_area_size( )

	print( "[_iv2_screen_size_]:" , iv2_screen_size );
	print( "[_iv2_client_size_]:" , iv2_client_size );
	
func SCREENCODE_snap_screen_to_collected_settings( ):
	var pan_screen_edges : Panel = get_node( "PAN_SCREEN_EDGES" )
	pan_screen_edges.position.x = 0 
	pan_screen_edges.position.y = 0

	## JBI_021 #################################################
	##                                                        ##
	##  WRONG : iv2_screen_size                               ##
	##  _YES_ : iv2_client_size                               ##
	##--------------------------------------------------------##

	pan_screen_edges.size.x = iv2_client_size.x  ## BUG_FIX : JBI_021 : BUG_021 ##
	pan_screen_edges.size.y = iv2_client_size.y  ## BUG_FIX : JBI_021 : BUG_021 ##
	if( iv2_client_size.x <= 10 || iv2_client_size.y <= 10 ):
		WORLDFUNC_err( "[_VIEWPORT_SMALLER_THAN_10_X_10_]" )

	################################################# JBI_021 ##
	
func _on_viewport_size_changed( ):
	SCREENCODE_collect_screen_settings()
	SCREENCODE_snap_screen_to_collected_settings()
	WORLDFUNC_update_world_object_scales()
	## WORLDFUNC_update_level_number_value()
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
	## WORLDFUNC_update_level_number_value()
	pass

func SCREENCODE_exit_full_screen( ) :
	### var screen_id : int = DisplayServer.window_get_current_screen( 0 )
	var window_id = DisplayServer.MAIN_WINDOW_ID
	var WINDOWED : int = DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode( WINDOWED  , window_id )
	WORLDFUNC_update_world_object_scales()
	## WORLDFUNC_update_level_number_value()
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

###############--################################ SCREENCODE ###
### INPUTCODE #################################--###############

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

func INPUTCODE_all_debug_controls_here( ) :
	
	############################################################
	##                                                        ##
	##  YOUR SHORTCUT SCRIPT ON YOUR COMPUTER BLOCKS THE      ##
	##  ABILITY OF GODOT TO BE ABLE TO DETECT KEY DOWN !      ##
	##                                                        ##
	############################################################

	var dcd =( 10 ) ## @dcd@ : Debug_Cool_Down ## <<<<<<<<<<<<<<  [ JBI_025 ]

	var plus_equal_key_pressed = 0 
	if Input.is_key_pressed( KEY_PLUS  ) : plus_equal_key_pressed = 1 
	if Input.is_key_pressed( KEY_EQUAL ) : plus_equal_key_pressed = 1 

	if( Input.is_key_pressed( KEY_0 ) ) :
		WORLDDATA_n2d_ui.UIFUNC_hide_menu()
		pass
	if( Input.is_key_pressed( KEY_1 ) ) :
		WORLDDATA_n2d_ui.UIFUNC_show_menu_start()
		pass
	if( Input.is_key_pressed( KEY_2 ) ) :
		WORLDDATA_n2d_ui.UIFUNC_show_menu_win()
		pass
	if( Input.is_key_pressed( KEY_3 ) ) :
		WORLDDATA_n2d_ui.UIFUNC_show_menu_lose()
		pass


	if( Input.is_key_pressed( KEY_M ) ) :               ## <<<<<  [ JBI_026 ]
		WORLDDATA_are_we_on_the_opening_screen =( 1 )   ## <<<<<  [ JBI_026 ]
	if( Input.is_key_pressed( KEY_G ) ) :               ## <<<<<  [ JBI_026 ]
		WORLDDATA_are_we_on_the_opening_screen =( 0 )   ## <<<<<  [ JBI_026 ]

	if( Input.is_key_pressed( KEY_C ) ) : 

		if( WORLDDATA_increment_level_display_cooldown <= 0 ) :
			WORLDDATA_increment_level_display_cooldown =( dcd )
			WORLDFUNC_center_the_fucking_number( )
			MSG( "[_IAM_THE_CENTER_OF_THE_UNIVERSE_FOR_IAM_C_]" )

	if( Input.is_key_pressed( KEY_H ) ) : ## <<<<<<<<<<<<<<<<<<< [ JBI_025 ]

		if( WORLDDATA_increment_level_display_cooldown <= 0 ) :
			WORLDDATA_increment_level_display_cooldown =( dcd )
			WORLDFUNC_make_that_number_fucking_huge( )
			MSG( "[_IAM_FUCKING_HUGE_BITCH_]" )

	if( plus_equal_key_pressed  ) : ## <<<<<<<<<<<<<<<<<<<<<<<<< [ JBI_025 ]

		if( WORLDDATA_increment_level_display_cooldown <= 0 ) :
			WORLDDATA_increment_level_display_cooldown =( dcd )
			DEBUGFUNC_increment_level_number( )
			MSG( "[_KEY_PLUS_EQUAL_PRESSED_]" )
	
	if Input.is_key_pressed( KEY_D  ) : ## <<<<<<<<<<<<<<<<<<<<< [ JBI_027 ][ JBI_025 ]

		if( WORLDDATA_increment_level_display_cooldown <= 0 ) :
			WORLDDATA_increment_level_display_cooldown =( dcd )
			DEBUGFUNC_update_level_number_centering( )
			MSG( "[_KEY_ZERO_PRESSED_]" )

	if Input.is_key_pressed( KEY_DOWN  ) :
		if( true ) :
			## TAG[ key-down | down_key | downkey ]#############
			## TAG[ level_fast_forwarding_call_her ]############
			MSG( "[_ABOUT_TO_CALL_FAST_FOWARD_DEBUG_]" )
			WORLDFUNC_fast_forward_to_3_seconds_left( )
		
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

func INPUTCODE_main_outermost_input_handler( ) :
	if( true == nod_configcode.CONFIGDATA_use_debug_controls ) :
		INPUTCODE_all_debug_controls_here( )


###############--################################# INPUTCODE ###


## DOWN_ARROW_DEBUG ############################################
##                                                            ##
##  TAG[ down_arrow | down-arrow | downarrow ]                ##
##  TAG[ down-key   | down_key   | downkey   ]                ##
##                                                            ##
##  Where is the code that manages the down arrow input       ##
##  to fast forward to the end of the game ? I cannot find    ##
##  it and it seems to be broken at the moment ?              ##
##                                                            ##
##  SEE[ INPUTCODE .____. all_debug_controls_here ]           ##
##                                                            ##
############################################ DOWN_ARROW_DEBUG ##
################################################################
##                                                            ##
## $_LEVEL_NUMBER_AS_BG_ELEMENT_$                             ##
## $_LEVEL_NUMBER_BG_$                                        ##
##                                                            ##
## I think it would be interesting to keep the level number   ##
## as a large number in the background , maybe this number    ##
## scrolls up screen as dan falls ?                           ##
##                                                            ##
## The level number being out of focus before the birds       ##
## start comming into frame .                                 ##
##                                                            ##
################################################################
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
## LEVEL_NUMBER_DISPLAY ########################################
##                                                            ##
##  TAG[ level-number-display | level_number_display ]        ##
##  TAG[ levelnumberdisplay | level_display | leveldisplay ]  ##
##  TAG[ big_digit | big-digit | bigdigit | big-diggy ]       ##
##                                                            ##
##  Where is the code that manages the level number display ? ##
##                                                            ##
##  SEE[ WORLDFUNC .____. update_level_number_value ]         ##
##                                                            ##
######################################## LEVEL_NUMBER_DISPLAY ##
## $_IDEMPOTENT_$ ##############################################
##                                                            ##
## The line of code tagged with this can be called multiple   ##
## times in a row , no problem .                              ##
##                                                            ##
## Right now the level number code is getting un-centered     ##
## when the level resets and I have no fucking clue why.      ##
## If I call the function immediately twice in a row          ##
## the text is still centered , so something else is going    ##
## on here .                                                  ##
##                                                            ##
############################################## $_IDEMPOTENT_$ ##
## $_LABEL_CENTERING_BUG_$ #####################################
## $_LABEL_CENTER_BUG_$    #####################################
##                                                            ##
## For some reason when I reset the level , the label         ##
## sems to forget that it's anchor settings is supposed       ##
## to be configured to[ FULL_RECTANGLE ].                     ##
##                                                            ##
## Or at least, that is my best guess as to what is           ##
## going on , I really don't know .                           ##
##                                                            ##
#####################################    $_LABEL_CENTER_BUG_$ ##
##################################### $_LABEL_CENTERING_BUG_$ ##
## $_P_TWICE_$  ################################################
##                                                            ##
##  @P_TWICE@ : Position_TWICE                                ##
##                                                            ##
##  Does setting position property twice in a row cause       ##
##  the label to become mal-aligned ? Find out here .         ##
##                                                            ##
################################################ $_P_TWICE_$  ##
##  BUG_IN_GODOT_001  ##########################################
##                                                            ##
##  Maybe it's not a bug ... But holy fuck...                 ##
##  Basically spent 2 days ( 4 hours total ) tying to         ##
##  figure out why this control wouldn't center ...           ##
##                                                            ##
##  Maybe it's not a "bug" and "anchors preset" doesn't       ##
##  do what you think it does .                               ##
##                                                            ##
##########################################  BUG_IN_GODOT_001  ##
##  $_NUMBER_OF_CELLS_ON_X_AXIS_$  #############################
##  $_NUMBER_OF_CELLS_ON_Y_AXIS_$  #############################
##                                                            ##
##  Okay, so the problem is that we have an animated sprite   ##
##  and we are centering it by using the texture size as      ##
##  part of our calculation , but for our animated flag       ##
##  animation , we only see 1/9 of the texture because        ##
##  the texture is an animation strip .                       ##
##                                                            ##
##  THE FIX : We need to provide how many cells the texture   ##
##          : of the graphic has been split into on the       ##
##          : x and y axis to fix our calculations .          ##
##                                                            ##
#############################  $_NUMBER_OF_CELLS_ON_Y_AXIS_$  ##
#############################  $_NUMBER_OF_CELLS_ON_X_AXIS_$  ##
