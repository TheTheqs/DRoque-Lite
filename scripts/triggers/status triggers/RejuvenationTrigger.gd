extends Trigger

class_name RejuvenationTrigger
#preencher com atributos de identificação
func _init() -> void:
	self.triggerId = 37
	self.action = RejuvenationCure.new()
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(_digimon: Digimon, context) -> bool:
	if(context == "TurnStart"):
		return true
	return false
