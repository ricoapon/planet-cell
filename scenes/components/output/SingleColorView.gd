class_name SingleColorView
extends Panel

static var OUTPUT_TO_COLOR: Dictionary[SingleOutput.OutputColor, Color] = {
	SingleOutput.OutputColor.RED: Color.html("#dc3545"),
	SingleOutput.OutputColor.BLUE: Color.html("#0d6efd"),
	SingleOutput.OutputColor.GREEN: Color.html("#20c997")
}

const CORNER_RADIUS = 5

func init(output_color: SingleOutput.OutputColor, times_actual: int, times_expected: int):
	var style = StyleBoxFlat.new()
	style.set_corner_detail(10)
	style.bg_color = OUTPUT_TO_COLOR[output_color]
	add_theme_stylebox_override("panel", style)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_FILL
	if times_actual == null:
		times_actual = 0
	_set_text(times_actual, times_expected)

func _set_text(times_actual: int, times_expected: int):
	$Label.text = str(times_actual) + "/" + str(times_expected)

func use_rounded_corners_left():
	get_theme_stylebox("panel").corner_radius_top_left = CORNER_RADIUS
	get_theme_stylebox("panel").corner_radius_bottom_left = CORNER_RADIUS

func use_rounded_corners_right():
	get_theme_stylebox("panel").corner_radius_top_right = CORNER_RADIUS
	get_theme_stylebox("panel").corner_radius_bottom_right = CORNER_RADIUS
