extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(1, 1, 1, 0);

func change_text(inner_text : String):
	text = inner_text;
	modulate.a = 0.0;
	var tween = create_tween();
	tween.tween_property(self, "modulate:a", 1.0, 0.5);
	tween.tween_property(self, "modulate:a", 1.0, 2);
	tween.tween_property(self, "modulate:a", 0.0, 0.5);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
