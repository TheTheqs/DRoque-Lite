extends StatusEffect

class_name Sleep
#construtora
func _init() -> void:
	self.statusId = 22
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Sleep.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.statusTriggers.append(SleepTrigger.new())

func applyingEffect(digimon: Digimon) -> void:
	digimon.isDisabled = true
	digimon.onTurnStart.append(self.statusTriggers[0])
	digimon.onGetDamage.append(self.statusTriggers[0])

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.isDisabled = false
	digimon.onTurnStart.erase(self.statusTriggers[0])
	digimon.onGetDamage.erase(self.statusTriggers[0])
	digimon.currentAnimation = "Idle"
	digimon.digimonAnimator.play("Idle")

func getStatus() -> StatusEffect:
	return Sleep.new()
