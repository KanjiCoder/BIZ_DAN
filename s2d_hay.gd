extends Sprite2D

@onready var n2d_world : Node2D = get_tree().root.get_child(0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process( _delta ):
	n2d_world.WORLDDATA_hay_cooldown -=( 1 )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta):
	pass


func _on_a2d_hay_body_entered(body):
	if( n2d_world.WORLDDATA_hay_cooldown <= 0 ):
		n2d_world.WORLDDATA_hay_cooldown =( 60*2 )

		n2d_world.WORLDDATA_has_dan_hit_the_hay_this_level =(1)
		n2d_world.WORLDFUNC_win_level( )
		## n2d_world.WORLDDATA_level +=( 1 ) ##<-- win_level()##

		print( "[_HITTING_THE_HAY_]" )
		pass # Replace with function body.
		


##
## FUCKING GODOT MAN !!! Always with this "a_2d" instead
## of the actual abbreviation of "a2d" . Snake Case ,
## Do you speak it mother fucker ?!
##
func _on_a_2d_hay_body_entered(body):
	_on_a2d_hay_body_entered( body )
	## TAG[ $_HANDLE_HITTING_THE_HAY_$ ] ##
	## TAG[ $_HANDLE_HITTING_HAY_$     ] ##








## $_HANDLE_HITTING_THE_HAY_$ ##################################
## $_HANDLE_HITTING_HAY_$     ##################################
##                                                            ##
##  If we hit the hay , we should proceed to the next level.  ##
##  If we miss the hay , we need to die and restart from      ##
##  the beginning .                                           ##
##                                                            ##
##################################   $_HANDLE_HITTING_HAY_$   ## 
################################## $_HANDLE_HITTING_THE_HAY_$ ## 
