extends Trigger

class_name CoolDownTrigger

func _init() -> void:
	self.isActionTrigger = false

func checkContext(digimon: Digimon, context) -> bool:
	if(context == "TurnEnd"):
		for skill in digimon.digimonSkills:
			if(skill != null):
				skill.countCooldown(digimon)
	return false
