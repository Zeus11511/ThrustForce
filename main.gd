extends Node

@onready var level = $LevelManager/Level;
@onready var control = $Control;
@onready var main_menu = $Control/MainMenu;
@onready var complete_screen = $Control/CompleteScreen;
@onready var button_continue = $Control/MainMenu/ButtonContinue;
@onready var main_song = $MainTheme;
@onready var pause_screen = $Control/PauseScreen;
var current_level = 0;
var coin_amount = 0;
var retry_amount = 0;

var player;

func _ready():
	GameData.load_game();
	if GameData.current_level == current_level:
		button_continue.disabled = true;

func start():
	player = load("res://player.tscn").instantiate();
	main_menu.visible = false;
	main_song.play();
	main_song.pitch_scale = 1.0 + current_level *  0.015;
	add_child(player);
	player.level_complete.connect(_on_level_complete);
	player.level_failed.connect(_on_level_fail);
	load_level();

func _on_level_complete():
	current_level += 1;
	if current_level < GameData.levels.size() - 1:
		GameData.save_game(current_level, coin_amount);
	coin_amount = 0;
	retry_amount = 0;
	main_song.pitch_scale = 1.0 + current_level *  0.015;
	player.set_process(true);
	load_level();

func _on_level_fail():
	var position = level.get_child(0).get_node("LaunchPad").position;
	if retry_amount < GameData.encouragement_captions.size():
		control.change_text(GameData.encouragement_captions[retry_amount]);
	retry_amount += 1;
	player.linear_velocity = Vector3.ZERO;
	player.rotation = Vector3.ZERO;
	player.position = Vector3(position.x, position.y + 0.25, position.z);
	player.is_transitioning = false;
	
func load_level():
	if GameData.levels.size() == current_level:
		game_complete();
	else:
		var next_level = load(GameData.levels[current_level]).instantiate();
		var position = next_level.get_node("LaunchPad").position;
		player.rotation = Vector3.ZERO;
		player.position = Vector3(position.x, position.y + 0.25, position.z);
		player.is_transitioning = false;
		if level.get_children().size() > 0:
			level.get_child(0).queue_free();
		control.change_text(GameData.level_captions[current_level]);
		control.change_level(current_level + 1);
		level.add_child(next_level);

func game_complete():
	complete_screen.visible = true;


func _on_button_continue_pressed():
	current_level = GameData.current_level;
	start();

func _on_button_new_pressed():
	start();


func _on_button_levels_pressed():
	pass # Replace with function body.

func _on_button_exit_pressed():
	get_tree().quit();

func _on_pause_exit_pressed():
	get_tree().quit();
	
func _unhandled_input(event):
	if event.is_action_pressed("Pause") && not main_menu.visible:
		pause_screen.visible = true;
		get_tree().paused = true;


func _on_pause_continue_pressed():
	pause_screen.visible = false;
	get_tree().paused = false;


func _on_pause_main_menu_pressed():
	get_tree().paused = false;
	get_node("Player").queue_free();
	pause_screen.visible = false;
	level.get_child(0).queue_free();
	main_song.stop();
	main_song.seek(0);
	main_menu.visible = true;


func _on_main_theme_finished():
	main_song.play();
	main_song.pitch_scale = 1.0 + current_level *  0.015;
