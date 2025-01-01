extends Trigger

class_name RegenTrigger
#preencher com atributos de identificação
func _init() -> void:
	self.triggerId = 7
	self.action = RegenCure.new()
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(_digimon: Digimon, context) -> bool:
	if(context == "TurnStart"):
		return true
	return false
