extends Control

@onready var level_caption : Label = $CenterContainer/LevelCaption;
@onready var level_tag : Label = $BoxContainer/Label;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_text(text : String):
	level_caption.change_text(text);
	
func change_level(level : int):
	level_tag.change_level(level);
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
