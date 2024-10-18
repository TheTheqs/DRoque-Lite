extends Trigger

class_name FocusTrigger0
var relatedFocus: Focus
#preencher com atributos de identificação
func _init(nFocus: Focus) -> void:
	self.triggerId = 35
	self.relatedFocus = nFocus

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill):
		if(digimon.criticalChance < 100.0):
			digimon.criticalChance = 100.0
	return false
