extends Node
@onready var nod_cloudcode = get_node("/root/N2D_WORLD/NOD_CLOUDCODE")
@onready var nod_birdcode  = get_node("/root/N2D_WORLD/NOD_BIRDCODE")

##    .----1----2----3----4----5----.    ##
##  [___][_1_][_2_][_3_][_4_][_5_][___]  ##
## 	[0/6][1/6][2/6][3/6][4/6][5/6][6/6]  ##
var spawn_slots       =[ 0 , 0 , 0 , 0 , 0 ]   ## 0 to 4 spawn slots ##
var spawn_div   : int =( 6 ) ## sixths ##
var spawns_per_second =( 1 ) ## Number of spawned items per second ##
var spawn_tick_wait_time =( SPAWNFUNC_calc_spawn_tick_wait_time() )
var spawn_tick_cooldown  =( 0 )

## Somewhat random , but should eventually be weighted so that
## the longer the level progresses, the more likely that you
## are going to spawn a[ GOOSE ]instead of a[ CLOUD ].
func SPAWNFUNC_zero_for_cloud_one_for_bird( ) :
	var c0_b1 =( randi_range( 0,1 ))
	return( c0_b1 )
	
func SPAWNFUNC_spawn_bird_or_cloud( ) :
	var spawn_per = SPAWNFUNC_get_next_spawn_percent( )
	## nod_cloudcode.CLOUDFUNC_ping()
	## p_rint( "[_spawn_per_]" , spawn_per )
	var c0_b1 = SPAWNFUNC_zero_for_cloud_one_for_bird()
	if( c0_b1 == 0 ) : nod_cloudcode.CLOUDFUNC_spawn_cloud_by_percent( spawn_per )
	if( c0_b1 == 1 ) : nod_birdcode.BIRDFUNC_spawn_goose_by_percent( spawn_per )
	pass
	
func _physics_process( _delta ) :
	spawn_tick_cooldown -= 1
	if( spawn_tick_cooldown <= 0 ) :
		spawn_tick_cooldown = spawn_tick_wait_time
		SPAWNFUNC_spawn_bird_or_cloud( )
	##  SPAWNFUNC_spawn_cloud_or_bird <-- WRONG, USE ALPHABETICAL !!
	pass

func SPAWNFUNC_calc_spawn_tick_wait_time( ) :
	var wait_time_in_ticks =( 60.0 / spawns_per_second )
	return( wait_time_in_ticks )

func SPAWNFUNC_get_next_spawn_slot_index( ) :
	var slot = randi_range( 0 , 4 )
	
	## If slot already taken, move to the next
	## free slot, if no free slots , reset slot array.
	if( spawn_slots[ slot ] >= 1 ) :
		## Searching the first slot to right of taken
		## slot would be best . And wrapping around ..
		## But I don't got time for that shit and no one cares .
		for s in range( 0,4 ) :
			if( spawn_slots[ s ] <= 0 ) :
				slot = s 
				break
			if( 4 == s ) :
				spawn_slots[ 0 ] = 0 
				spawn_slots[ 1 ] = 0 
				spawn_slots[ 2 ] = 0 
				spawn_slots[ 3 ] = 0 
				spawn_slots[ 4 ] = 0 
			pass
	spawn_slots[ slot ]=( 1 ) ## Flag Slot As Taken
	return( slot )
	
func SPAWNFUNC_get_next_spawn_percent( ) :
	var slot = SPAWNFUNC_get_next_spawn_slot_index()
	var fraction_top  : int = slot + 1  
	var fraction_bot  : int = spawn_div
	var final_percent : float = float( fraction_top ) / float( fraction_bot )
	return( final_percent )
	
func _ready():
	pass # Replace with function body.
func _process( _delta ):
	pass
