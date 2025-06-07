class_name Level
extends RefCounted

static var all: Array[Level] = [
	Level.new(
		# Requires player to only draw a line.
		"Tutorial",
		"eyJjb29yZGluYXRlX3RvX2Jsb2NrIjp7IntcInhcIjoxLFwieVwiOjR9Ijp7InR5cGUiOjJ9LCJ7XCJ4XCI6NSxcInlcIjo0fSI6eyJjb2xvciI6MCwidHlwZSI6MH19LCJlZGdlcyI6W10sImV4cGVjdGVkX291dHB1dCI6eyJyb3dzIjpbeyIwIjoxLCIxIjowLCIyIjowfV19LCJoZWlnaHQiOjEwLCJ3aWR0aCI6MTB9"
	),
	Level.new(
		# Requires player to place some blocks.
		"Tutorial 2",
		"eyJjb29yZGluYXRlX3RvX2Jsb2NrIjp7IntcInhcIjoxLFwieVwiOjN9Ijp7InR5cGUiOjJ9LCJ7XCJ4XCI6NCxcInlcIjo0fSI6eyJjb2xvciI6MCwidHlwZSI6MH19LCJlZGdlcyI6W10sImV4cGVjdGVkX291dHB1dCI6eyJyb3dzIjpbeyIwIjoyLCIxIjowLCIyIjowfV19LCJoZWlnaHQiOjEwLCJ3aWR0aCI6MTB9"
	),
	Level.new(
		# Still possible to achieve without splitting.
		"Tutorial 3",
		"eyJjb29yZGluYXRlX3RvX2Jsb2NrIjp7IntcInhcIjoxLFwieVwiOjN9Ijp7InR5cGUiOjJ9LCJ7XCJ4XCI6NCxcInlcIjo0fSI6eyJjb2xvciI6MCwidHlwZSI6MH19LCJlZGdlcyI6W10sImV4cGVjdGVkX291dHB1dCI6eyJyb3dzIjpbeyIwIjoyLCIxIjowLCIyIjowfV19LCJoZWlnaHQiOjEwLCJ3aWR0aCI6MTB9"
	),
	Level.new(
		# The player should now learn how to split to increase power.
		"Tutorial 4",
		"eyJjb29yZGluYXRlX3RvX2Jsb2NrIjp7IntcInhcIjoxLFwieVwiOjR9Ijp7InR5cGUiOjJ9LCJ7XCJ4XCI6NSxcInlcIjo0fSI6eyJjb2xvciI6MCwidHlwZSI6MH19LCJlZGdlcyI6W10sImV4cGVjdGVkX291dHB1dCI6eyJyb3dzIjpbeyIwIjo0LCIxIjowLCIyIjowfV19LCJoZWlnaHQiOjEwLCJ3aWR0aCI6MTB9"
	),
	Level.new(
		# Now we need some way to keep looping.
		"Tutorial 5",
		"eyJjb29yZGluYXRlX3RvX2Jsb2NrIjp7IntcInhcIjoxLFwieVwiOjF9Ijp7InR5cGUiOjJ9LCJ7XCJ4XCI6MyxcInlcIjo1fSI6eyJjb2xvciI6MCwidHlwZSI6MH19LCJlZGdlcyI6W10sImV4cGVjdGVkX291dHB1dCI6eyJyb3dzIjpbeyIwIjoyLCIxIjowLCIyIjowfSx7IjAiOjIsIjEiOjAsIjIiOjB9LHsiMCI6MiwiMSI6MCwiMiI6MH0seyIwIjoyLCIxIjowLCIyIjowfSx7IjAiOjIsIjEiOjAsIjIiOjB9XX0sImhlaWdodCI6MTAsIndpZHRoIjoxMH0="
	),
]

var title: String
var level_code: String

func _init(_title: String, _level_code: String) -> void:
	title = _title
	level_code = _level_code
