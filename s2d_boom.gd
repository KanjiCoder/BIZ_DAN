extends Sprite2D
@onready var n2d_world : Node2D = get_tree().root.get_child(0)

var boom_frame : int = (0-1) 

################################################################
## Explosions don't need a fancy manager :                    ##
## DONT_NEED : WORLDDATA_array_explosion_length               ##
## DONT_NEED : WORLDDATA_array_explosion                      ##
## Once the explosion is older than 3 seconds , remove it !   ##
## HOLY FUCK.... We are already doing that with "boom_frame" !##
## I thought I was about to fix a memory leak.                ##
## -KanjiCoder                                                ##
## var m_manager_index : int =( 0-1 )                         ##
################################################################

func _physics_process( _delta ):
	boom_frame += 1
	self.set_frame( boom_frame ) 
	if( boom_frame >= 11 ): self.visible = false 
	if( boom_frame >= 30 ): self.queue_free()
	pass

	## JBI_021 #################################################
	##                                                        ##
	##  Make the explosions rotate . I don't know if Josh     ##
	##  meant "rotate while exploding" or rotate on spawn..   ##
	##  So , they all rotate when spawned , but they can      ##
	##  also rotate when exploding if the configuration       ##
	##  variable is set to true .                             ##
	##                                                        ##
	##--------------------------------------------------------##

	var explosions_rotate_while_exploding =( 
	n2d_world.
	nod_configcode.
	CONFIGDATA_explosions_rotate_while_exploding 
	)
	if( explosions_rotate_while_exploding ) :
		var cur = self.get_rotation_degrees( ) 
		var new = cur + 15
		self.set_rotation_degrees( new )

	################################################# JBI_021 ##
	
func _ready():
	self.set_rotation_degrees( randi_range(0,360) );
	$ASP_BOOM.play()
	pass # Replace with function body.

func _process(delta):
	pass
