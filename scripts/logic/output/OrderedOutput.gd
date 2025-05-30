class_name OrderedOutput
extends RefCounted

var _rows: Array[SingleOutput] = []

# The caller needs to make sure to first call next_row() before using this method.
func add_output_to_current_row(output: SingleOutput):
	var current_row_output = _rows[-1]
	current_row_output.add_output(output)

func next_row():
	_rows.append(SingleOutput.new())

func fully_contains(other: OrderedOutput) -> bool:
	if other._rows.size() > _rows.size():
		return false
	
	for i in other._rows.size():
		var output = _rows[i]
		var other_output = other._rows[i]
		
		if not output.equals(other_output):
			return false
	
	return true

func equals(other: OrderedOutput) -> bool:
	return fully_contains(other) and other.fully_contains(self)

func _to_string() -> String:
	var result = "OrderedOutput["
	for output in _rows:
		result += output._to_string() + ","
	return result + "]"
