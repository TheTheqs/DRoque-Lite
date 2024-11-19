extends Trigger

class_name SavageInstinctTrigger
var gotBravery: bool = false
var braveryBuff: Bravery = Bravery.new(2)
#aqui, action vai ser a passiva que este trigger está diretamente relacionado
func _init(relatedPassiveSkill: PassiveSkill) -> void:
	action = relatedPassiveSkill

func checkContext(digimon: Digimon, context) -> bool:
	if(context is String and context == "BattleStart"):
		self.gotBravery = false
		return true
	elif(context is DamageData and Util.getProportion(digimon.currentHealth, digimon.maxHelth) <= 0.5 and !gotBravery):
		gotBravery = true
		digimon.skillAnnouncer.announceSkill(self.action.skillIcon)
		digimon.applyStatus(self.braveryBuff)
		return false
	else:
		return false
