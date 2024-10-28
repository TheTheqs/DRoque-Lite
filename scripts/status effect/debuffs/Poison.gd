extends StatusEffect

class_name Poison
#construtora
func _init() -> void:
	self.statusId = 0
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Poison.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(PoisonTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onTurnEnd.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newPoison: Poison  = Poison.new()
	newPoison.schance = self.schance
	return newPoison
