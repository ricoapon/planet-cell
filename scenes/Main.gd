extends Control

@onready var EditGridScreenScene = preload("res://scenes/screens/EditGridScreen.tscn")
@onready var PlayGridScreenScene = preload("res://scenes/screens/PlayGridScreen.tscn")
@onready var MenuScreenScene = preload("res://scenes/screens/MenuScreen.tscn")
@onready var SelectLevelScreenScene = preload("res://scenes/screens/SelectLevelScreen.tscn")

var current_screen

func _ready():
	load_menu_screen()

func clear():
	if current_screen == null:
		return
	current_screen.queue_free()
	current_screen = null

func load_menu_screen():
	clear()
	current_screen = MenuScreenScene.instantiate()
	add_child(current_screen)
	current_screen.connect("go_to_editor", load_editor)
	current_screen.connect("go_to_select_level", load_select_level)

func load_editor(grid: Grid):
	clear()
	current_screen = EditGridScreenScene.instantiate()
	add_child(current_screen)
	current_screen.init(grid)
	current_screen.connect("go_to_play_screen", load_play_from_editor)
	current_screen.connect("back", load_menu_screen)

func load_play_from_editor(grid: Grid):
	clear()
	current_screen = PlayGridScreenScene.instantiate()
	add_child(current_screen)
	current_screen.init(grid, true)
	current_screen.connect("go_to_editor", load_editor)
	current_screen.connect("back", load_menu_screen)

func load_select_level():
	clear()
	current_screen = SelectLevelScreenScene.instantiate()
	add_child(current_screen)
	current_screen.connect("go_to_level", load_level)
	current_screen.connect("back", load_menu_screen)

func load_level(level_index: int):
	clear()
	var grid = GridCode.convert_to_grid(Level.all[level_index].level_code)
	current_screen = PlayGridScreenScene.instantiate()
	add_child(current_screen)
	current_screen.init(grid)
	current_screen.connect("back", load_select_level)
	if Level.all.size() > level_index + 1:
		current_screen.connect("next_level", func(): load_level(level_index + 1))
	else:
		current_screen.connect("next_level", load_menu_screen)
