extends Node

## @onready var n2d_world = get_node( "N2D_WORLD" )
@onready var n2d_world : Node2D = get_tree().root.get_child(0)

## If game is 1 minute and 30 seconds , that is ( 30+30+30 ) seconds .
## So... 5 seconds of no clouds at start ...
## ..... 5 seconds of no clouds at end......
## So we need to partition the 1 minute and 30 seconds into
## 5 second chunks... So... (30+30+30)===(90)
## 90 / 5 === 18 , we need 18 sectors to configure
## the probability of GOOSE or CLOUD .

var CONFIGDATA_maximum_goose_override   : bool = true  ## FOR_DEBUG_ONLY ##
var CONFIGDATA_start_with_3_seconds_left : bool = true  ## FOR_DEBUG_ONLY ##

var CONFIGDATA_game_duration_in_minutes : float = 1.5
var CONFIGDATA_prob_cloud =[ 0 , 1,1,1,1  , 9,8,7,6 , 5,4,3,2 , 1,0,0,0  , 0 ]
var CONFIGDATA_prob_goose =[ 0 , 0,0,0,0  , 1,2,3,4 , 5,6,7,8 , 9,1,1,1  , 0 ]
var CONFIGDATA_prob_length =( 18 ) ## 18 elements in probability array ##

func CONFIGFUNC_INI( ):
	var l_e_n = CONFIGDATA_prob_length 
	if( CONFIGDATA_prob_cloud.size() != l_e_n ) : error_string( 1 ) 
	if( CONFIGDATA_prob_goose.size() != l_e_n ) : error_string( 2 ) 
	pass # Replace with function body.

func CONFIGFUNC_0none_1cloud_2goose( ) :
	## Use tilemap math to abstract each "probability cell" as a cell
 	## with a width of 10 units , and then use tilemap math to figure
	## out which cell you are in. We do this so that the 0% and 100%
	## percent along paths map to a REGION rather than a POINT...
	## I don't know how to describe it. But we need to do it this way
	## to distribute all 18 probability slices evenly .
	var tcw : float =( 10 ) ## @tcw@ : Time_Cell_Width ##
	var pt  : float = ( n2d_world.WORLDDATA_percent_scroll * CONFIGDATA_prob_length * tcw )
	var tci : int    = floor( pt / tcw ) ## @tci@ : Time_Cell_Index ##
	if( tci >= CONFIGDATA_prob_length ) : tci =( CONFIGDATA_prob_length - 1 )
	pass
	var prob_cloud : int =( CONFIGDATA_prob_cloud[ tci ] )
	var prob_goose : int =( CONFIGDATA_prob_goose[ tci ] )
	var spawn_enum : int = 0
	if( 0 == prob_cloud && 0 == prob_goose ) :
		spawn_enum = 0
	else :
		spawn_enum = 2 ## Goose Unless OverWritten 
		var prob_total =( prob_cloud + prob_goose )
		var r_i =( randi_range( 1 , prob_total ))
		if( r_i <= prob_cloud ) : spawn_enum = 1
	pass
	if( CONFIGDATA_maximum_goose_override ) :
		spawn_enum =( 2 )
	
	return spawn_enum 
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass ## Use CONFIGFUNC_INI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
