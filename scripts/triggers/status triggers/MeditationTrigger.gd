extends Trigger

class_name MeditationTrigger
#preencher com atributos de identificação
func _init() -> void:
	self.triggerId = 17
	self.action = MeditationCure.new()
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(_digimon: Digimon, context) -> bool:
	if(context == "TurnStart"):
		return true
	return false
