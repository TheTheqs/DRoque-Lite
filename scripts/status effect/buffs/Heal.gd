extends StatusEffect

class_name Heal
#value
var healValue: float
var isMana: bool

func _init(newValue: float, nisMana: bool) -> void:
	self.healValue = newValue
	self.isMana = nisMana
	self.statusId = 41
	self.statusType = Enums.StatusType.BUFF

func applyingEffect(digimon: Digimon) -> void:
	digimon.heal(healValue, isMana)

func getStatus() -> StatusEffect:
	return Heal.new(self.healValue, self.isMana)
