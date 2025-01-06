extends Trigger

class_name CharmTrigger
#preencher com atributos de identificação
func _init() -> void:
	self.triggerId = 24

func checkContext(digimon: Digimon, context) -> bool:
	if(context is DamageSkill) and context != null:
		context.manageUsability(1)
	if(digimon.tamer is Player):
		digimon.tamer.buttonPanel.manageSkillUtility()
	return false
