extends StatusEffect

class_name Mark
#construtora
func _init() -> void:
	self.statusId = 18
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Mark.png")
	self.setStats()
	self.schance = -1
	self.statusType = Enums.StatusType.DEBUFF

func applyingEffect(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(19)):
		digimon.unapplyStatus(19)
	digimon.statusImunity.append(19)


func unapplyingEffect(digimon: Digimon) -> void:
	digimon.statusImunity.erase(19)

func getStatus() -> StatusEffect:
	var newMark: Mark = Mark.new()
	return newMark
