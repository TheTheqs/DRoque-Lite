extends StatusEffect

class_name Exhaust
#construtora
func _init() -> void:
	self.statusId = 30
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Exhaust.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(ExhaustTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.onDamageCalc.erase(self.statusTriggers[0])

func getStatus() -> StatusEffect:
	var newExhaust: Exhaust = Exhaust.new()
	newExhaust.schance = self.schance
	return newExhaust
