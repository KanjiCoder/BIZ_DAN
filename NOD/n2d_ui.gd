extends Node2D
@onready var n2d_world : Node2D = get_tree().root.get_child(0)

func UIFUNC_get_client_area( ) :
	var client_area : Vector2i = n2d_world.SCREENCODE_bug_cant_get_real_client_area_size( )
	return client_area
	
func UIFUNC_show_menu( ) :
	self.visible = true
	
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
