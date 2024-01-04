extends Sprite2D

## @onready var n2d_world = get_node( "N2D_WORLD" )
@onready var n2d_world : Node2D = get_tree().root.get_child(0)
var cloudspeed : int = 3
var m_manager_index : int =( 0-1 )

func _physics_process( _delta ):
	offset.y -= cloudspeed
	if( offset.y < (0-512) ) : 
		## self.queue_free()    
		n2d_world.nod_cloudcode.CLOUDFUNC_free_cloud( self )
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	## print( n2d_world.WORLDDATA_has_process_been_hit_at_least_once )
	## cloudspeed = randi_range( 1 , 3 )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
