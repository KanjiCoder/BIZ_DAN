extends Sprite2D
@onready var n2d_world : Node2D = get_tree().root.get_child(0)
var psr_boom : PackedScene = preload( "res://s2d_boom.tscn" )
var nod_dancode : Node =( null )
var s2d_dan  : Sprite2D =( null )
var goose_speed : int = 3

func _on_a2d_goose_body_entered( body ):
	print( "[_NEXT_TIME_GOOSE_COLLISION_CODE_HERE_]" )
	var s2d_boom = psr_boom.instantiate()
	## nod_dancode = get_node( "NOD_DANCODE" ) <-- I DONT KNOW HOW TO DO THIS ##
	s2d_dan =( n2d_world.DANDATA_s2d_dan )
	s2d_boom.position.x =( s2d_dan.position.x )
	s2d_boom.position.y =( s2d_dan.position.y )
	n2d_world.add_child( s2d_boom )
	
	pass # Replace with function body.

func _physics_process( _delta ) :
	position.y -= goose_speed
	if( position.y < (0-512) ) : self.queue_free()
	pass
	
func _ready():
	pass # Replace with function body.
	
func _process( _delta ):
	pass


## ARE YOU FUCKING KIDDING ME ?
## It has to be "a_2d" instead of "a2d" ?
##  func _on_a_2d_goose_body_entered(body):
##	print( "[WHAT_THE_FUCKING_HELL_HOW_DO_I_WIRE_THIS_UP]" )
##	pass # Replace with function body.
	

	
	
	
	
