extends Tamer

class_name Player

func _ready() -> void:
	summonDigimon(Util.random(0, 5))
