extends Trigger

class_name ConfuseTrigger
#preencher com atributos de identificação
func _init() -> void:
	self.triggerId = 34

func checkContext(digimon: Digimon, context) -> bool:
	if(context is String and context == "BeforeAction"):
		if(Util.chance(50.0)):
			digimon.BM.showMessage(tr(StringName("ConfuseMessage")))
			digimon.enemy = digimon
		else:
			digimon.enemy = digimon.tamer.opponent.digimon
	return false
