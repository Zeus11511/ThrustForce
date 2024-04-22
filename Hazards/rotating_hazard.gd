extends Marker3D

@export var rotation_speed = 90.0;
@export var is_rev : bool = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_z(-deg_to_rad(rotation_speed * delta));
