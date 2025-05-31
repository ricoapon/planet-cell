class_name SingleOutput
extends RefCounted

enum OutputColor {
	RED,
	BLUE,
	GREEN,
}

var _colors: Dictionary[OutputColor, int]

func _init():
	_colors = {}
	# Initialize all colors to 0, so we don't need to check if it is present or not.
	for color in OutputColor.values():
		_colors[color] = 0

func add_color(color: OutputColor, times: int):
	_colors[color] += times

func add_output(output: SingleOutput):
	for color in OutputColor.values():
		_colors[color] += output._colors[color]

func times_color_is_present(color: OutputColor) -> int:
	return _colors[color]

func equals(other: SingleOutput):
	return _colors == other._colors

func _to_string() -> String:
	var result = "SingleOutput["
	for color in SingleOutput.OutputColor.values():
		if _colors[color] == 0:
			continue
		result += SingleOutput.OutputColor.keys()[color] + ":" + str(_colors[color]) + ","
	return result + "]"
