extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_level(level : int):
	text = "level: " + str(level); 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
