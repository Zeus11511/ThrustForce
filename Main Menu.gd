extends Control


signal press_new;
signal press_continue;
signal press_levels;
signal press_exit;

@onready var button_new = $ButtonNew;
@onready var button_continue = $Buttoncontinue;
@onready var button_levels = $ButtonLevels;
@onready var button_exit = $ButtonExit;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_new_pressed():
	press_new.emit();
