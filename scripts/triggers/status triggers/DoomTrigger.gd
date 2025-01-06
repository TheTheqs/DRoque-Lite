extends Trigger

class_name DoomTrigger
var relatedDoom: Doom
#preencher com atributos de identificação
func _init(nDoom: Doom)-> void:
	action = DoomHit.new()
	self.relatedDoom = nDoom
	self.triggerId = 26

func checkContext(_digimon: Digimon, context) -> bool:
	if(context is String and context == "TurnEnd"):
		relatedDoom.setStack(-1)
		if(relatedDoom.stacks <= 0):
			return true
	return false
