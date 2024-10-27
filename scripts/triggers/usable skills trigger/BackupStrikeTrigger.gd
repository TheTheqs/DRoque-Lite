extends Trigger

class_name BackupStrikeTrigger
var basicAtackUsed: bool = false
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedSkill: Skill) -> void:
	action = relatedSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is BasicAtack):
		basicAtackUsed = true
		return false
	elif(context is BackupStrike and basicAtackUsed == true):
		digimon.getActions(1)
		basicAtackUsed = false
		return false
	elif(context is String and context == "TurnEnd"):
		basicAtackUsed = false
		return false
	else:
		return false
