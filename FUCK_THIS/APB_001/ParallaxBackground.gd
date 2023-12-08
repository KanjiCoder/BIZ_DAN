extends ParallaxBackground

var m_scroll_offset_x = 0
var m_scroll_offset_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	## var PB : ParallaxBackground = self
	m_scroll_offset_x += 1 
	m_scroll_offset_y += 1
	scroll_offset = Vector2( m_scroll_offset_x , m_scroll_offset_y )
