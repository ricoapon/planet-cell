class_name CoordinateDictionary
extends RefCounted

var _dict: Dictionary

func add(key: Coordinate, value: int):
	_dict[key.to_dict()] = value

func has(key: Coordinate) -> bool:
	return _dict.has(key.to_dict())

func get_value(key: Coordinate) -> int:
	return _dict[key.to_dict()]

func increment(key: Coordinate, value: int):
	if not has(key):
		add(key, 0)
	_dict[key.to_dict()] += value

func keys() -> Array[Coordinate]:
	# Typing issues...
	var result: Array[Coordinate] = []
	for value in _dict.keys().map(func(d): return Coordinate.from_dict(d)):
		result.append(value)
	return result
