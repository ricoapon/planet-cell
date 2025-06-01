extends Control

@onready var EditGridScreenScene = preload("res://scenes/screens/EditGridScreen.tscn")
@onready var PlayGridScreenScene = preload("res://scenes/screens/PlayGridScreen.tscn")
@onready var MenuScreenScene = preload("res://scenes/screens/MenuScreen.tscn")

var current_screen

func _ready():
	# At some point I should switch this to load_editor().
	load_editor(Grid.new(10, 10))

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

func load_editor(grid: Grid):
	clear()
	current_screen = EditGridScreenScene.instantiate()
	add_child(current_screen)
	current_screen.init(grid)
	current_screen.connect("go_to_play_screen", load_play)

func load_play(grid: Grid):
	clear()
	current_screen = PlayGridScreenScene.instantiate()
	add_child(current_screen)
	current_screen.init(grid)
	current_screen.connect("go_to_editor", load_editor)
