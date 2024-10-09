extends Node

class_name Trigger
#preencher com atributos de identificação
var isActionTrigger: bool
var action: Skill
#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(_digimon: Digimon) -> bool:
	return true

func triggerValidation(digimon: Digimon, context) -> void:
	if(checkContext(digimon)):
		if(self.isActionTrigger):
			digimon.actionsToGo.append(action)
		else:
			digimon.effectsToGo.append(self)

func effect(_digimon: Digimon) -> void:
	pass