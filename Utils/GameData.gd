extends Node

var level_coins = [];
var save_file = "user://rocket_boost.ini"
var levels = [
	"res://Level/level_1.tscn",
	"res://Level/level_2.tscn",
	"res://Level/level_3.tscn",
	"res://Level/level_4.tscn",
	"res://Level/level_5.tscn",
	"res://Level/level_6.tscn",
	"res://Level/level_7.tscn", 
	"res://Level/level_8.tscn", 
	"res://Level/level_9.tscn", 
]

var current_level = 0;

var level_captions = [
	"This level is easy",
	"Still easy",
	"Now it's getting fun",
	"Don't trip now",
	"Now this is cool",
	"Slice Slice Slice",
	"Uh oh, this is not good",
	"X marks the spot", 
	"Y ?????", 
]

var encouragement_captions = [
	"Don't lose hope",
	"You are so close",
	"Almost there",
	"Don't give up",
	"I believe in you",
	"Uh, almost",
	"I think you got it?", 
	"Something like that",
	"Yikes...",
	"I feel bad...",
	"This is not good",
	"I give up...."
]

func save_game(level : int, coins : int):
	var save = ConfigFile.new();
	var err = save.load(save_file);
	if err == OK:
		var last_level = save.get_value("game", "last_level", 0);
		if level > last_level:
			save.set_value("game", "last_level", level); 
		var last_coins_amount = save.get_value("game", str(level) + "_coins", 0);
		if coins > last_coins_amount:
			save.set_value("game", str(level) + "_coins", coins);
		
	save.save(save_file);


# Call this function to load the game data
func load_game():
	var save = ConfigFile.new()

	# Load the data from the file
	var error = save.load(save_file)
	if error != OK:
		print("Failed to load game")
		return

	# Retrieve the game data
	current_level = save.get_value("game", "last_level", 0)
	for i in range(levels.size()):
		level_coins.append(save.get_value("game", str(i) + "_coins", 0));
	
	print(current_level);
	
