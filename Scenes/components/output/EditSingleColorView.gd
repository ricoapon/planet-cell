class_name EditSingleColorView
extends SingleColorView

var output_color: SingleOutput.OutputColor

var times_expected: int

func init(_output_color: SingleOutput.OutputColor, times_actual: int, _times_expected: int):
	output_color = _output_color
	times_expected = _times_expected
	super.init(output_color, times_actual, times_expected)
	style_button($HBoxContainer/Minus)
	style_button($HBoxContainer/Plus)

func _set_text(_times_actual: int, _times_expected: int):
	$HBoxContainer/Expected.text = str(_times_expected)

func style_button(btn: Button):
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)  # transparent
	btn.add_theme_stylebox_override("normal", style)
	btn.add_theme_stylebox_override("focus", style)
	btn.add_theme_stylebox_override("hover", style)
	btn.add_theme_stylebox_override("pressed", style)

signal change_times(output_color: SingleOutput.OutputColor, delta: int)

func _on_plus_pressed() -> void:
	_emit_change_times(1)

func _on_minus_pressed() -> void:
	_emit_change_times(-1)

func _emit_change_times(delta: int):
	if times_expected + delta < 0:
		return

	times_expected += delta
	change_times.emit(output_color, delta)
	_set_text(0, times_expected)
