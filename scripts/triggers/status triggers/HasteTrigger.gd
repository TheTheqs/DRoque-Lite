extends Trigger

class_name HasteTrigger
var relatedHaste: Haste
#preencher com atributos de identificação
func _init(nHaste: Haste) -> void:
	self.triggerId = 1
	self.relatedHaste = nHaste
#funções de checagem. A primeira é para ser sobreescrita.

func checkContext(digimon: Digimon, context) -> bool:
	if(context == "TurnStart"):
		digimon.tamer.showContent("+1 " + tr(StringName("Action")))
		digimon.getActions(1)
	return false
