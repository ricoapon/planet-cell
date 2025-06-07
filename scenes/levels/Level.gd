class_name Level
extends RefCounted

static var all: Array[Level] = [
	Level.new(
		"Introduction 1",
		"eyJjb29yZGluYXRlX3RvX2Jsb2NrIjp7IntcInhcIjoxLFwieVwiOjN9Ijp7InR5cGUiOjJ9LCJ7XCJ4XCI6MyxcInlcIjozfSI6eyJjb2xvciI6MCwidHlwZSI6MH19LCJlZGdlcyI6W3siZnJvbSI6eyJ4IjoxLCJ5IjozfSwidG8iOnsieCI6MywieSI6M319XSwiZXhwZWN0ZWRfb3V0cHV0Ijp7InJvd3MiOlt7IjAiOjEsIjEiOjAsIjIiOjB9XX0sImhlaWdodCI6MTAsIndpZHRoIjoxMH0="
	),
	Level.new(
		"Introduction 2",
		"eyJjb29yZGluYXRlX3RvX2Jsb2NrIjp7IntcInhcIjowLFwieVwiOjl9Ijp7InR5cGUiOjJ9LCJ7XCJ4XCI6MixcInlcIjo5fSI6eyJjb2xvciI6MCwidHlwZSI6MH19LCJlZGdlcyI6W3siZnJvbSI6eyJ4IjowLCJ5Ijo5fSwidG8iOnsieCI6MiwieSI6OX19XSwiZXhwZWN0ZWRfb3V0cHV0Ijp7InJvd3MiOlt7IjAiOjEsIjEiOjAsIjIiOjB9XX0sImhlaWdodCI6MTAsIndpZHRoIjoxMH0="
	),
	
]

var title: String
var level_code: String

func _init(_title: String, _level_code: String) -> void:
	title = _title
	level_code = _level_code
