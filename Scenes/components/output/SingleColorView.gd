class_name SingleColorView
extends ColorRect

const OUTPUT_TO_COLOR: Dictionary[SingleOutput.OutputColor, Color] = {
	SingleOutput.OutputColor.YELLOW: Color.YELLOW,
	SingleOutput.OutputColor.RED: Color.RED,
	SingleOutput.OutputColor.BLUE: Color.BLUE,
	SingleOutput.OutputColor.GREEN: Color.GREEN
}

func init(output_color: SingleOutput.OutputColor, times: int):
	color = OUTPUT_TO_COLOR[output_color]
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_FILL
	$Label.text = str(times)
