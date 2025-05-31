class_name SingleColorView
extends Panel

const OUTPUT_TO_COLOR: Dictionary[SingleOutput.OutputColor, Color] = {
	SingleOutput.OutputColor.YELLOW: Color.YELLOW,
	SingleOutput.OutputColor.RED: Color.RED,
	SingleOutput.OutputColor.BLUE: Color.BLUE,
	SingleOutput.OutputColor.GREEN: Color.GREEN
}

const CORNER_RADIUS = 5

func init(output_color: SingleOutput.OutputColor, times_actual: int, times_expected: int):
	var style = StyleBoxFlat.new()
	style.set_corner_detail(10)
	style.bg_color = OUTPUT_TO_COLOR[output_color]
	add_theme_stylebox_override("panel", style)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_FILL
	$Label.text = str(times_actual) + "/" + str(times_expected)

func use_rounded_corners_left():
	get_theme_stylebox("panel").corner_radius_top_left = CORNER_RADIUS
	get_theme_stylebox("panel").corner_radius_bottom_left = CORNER_RADIUS

func use_rounded_corners_right():
	get_theme_stylebox("panel").corner_radius_top_right = CORNER_RADIUS
	get_theme_stylebox("panel").corner_radius_bottom_right = CORNER_RADIUS
