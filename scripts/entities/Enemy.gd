extends Tamer

class_name Enemy

func _ready() -> void:
		summonDigimon(Util.random(0, 5))
