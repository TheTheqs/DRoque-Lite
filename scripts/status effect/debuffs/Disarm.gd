extends StatusEffect

class_name Disarm
#construtora
func _init(nduration: int) -> void:
	self.statusId = 36
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Disarm.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isExpirable = true
	self.duration = nduration
	self.statusTriggers.append(DisarmTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	if(digimon.armory[0] != null):
		digimon.unequipItem(0)
	digimon.onActing.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onActing.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newDisarm: Disarm = Disarm.new(self.duration)
	return newDisarm
