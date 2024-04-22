extends Control

@onready var rich_text_label = $CenterContainer/RichTextLabel;
@onready var background = ColorRect.new();
@onready var levels_button = Button.new();
@onready var exit_button = Button.new();
@onready var continue_button = Button.new();
@onready var new_button = Button.new();
# Called when the node enters the scene tree for the first time.
func _ready():
	background.color = Color(1, 0, 0, 0.5);
	background.custom_minimum_size = Vector2(GlobalSettings.window_width, GlobalSettings.window_height);
	add_child(background);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
