extends StatusEffect

class_name Stun
#construtora
func _init() -> void:
	self.statusId = 8
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Stun.png")
	self.setStats()
	self.statusType = Enums.StatusType.DEBUFF
	self.isExpirable = true
	self.canCount = true
	self.duration = 1
	

func applyingEffect(digimon: Digimon) -> void:
	digimon.isDisabled = true

func unapplyingEffect(digimon: Digimon) -> void:
	digimon.isDisabled = false
	digimon.currentAnimation = "Idle"
	digimon.digimonAnimator.play("Idle")

func getStatus() -> StatusEffect:
	var newStun: Stun = Stun.new()
	newStun.schance = self.schance
	return newStun
