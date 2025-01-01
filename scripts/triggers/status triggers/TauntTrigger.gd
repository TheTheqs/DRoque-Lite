extends Trigger

class_name TauntTrigger
var relatedTaunt: Taunt
#preencher com atributos de identificação
func _init(nTaunt: Taunt) -> void:
	self.triggerId = 4
	self.relatedTaunt = nTaunt

#funções de checagem. A primeira é para ser sobreescrita.
func checkContext(digimon: Digimon, context) -> bool:
	if!(context is DamageSkill) and context != null:
		context.manageUsability(1)
	if(digimon.tamer is Player):
		digimon.tamer.buttonPanel.manageSkillUtility()
	return false
