extends StatusEffect

class_name Unstoppable
var blockedStatus: Array[int] = [6, 8, 22, 16]
func _init(nDuration: int) -> void:
	self.statusId = 15
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Unstoppable.png")
	self.isExpirable = true
	self.duration = nDuration
	self.setStats()
	self.statusType = Enums.StatusType.BUFF


func applyingEffect(digimon: Digimon) -> void:
	for nId : int in blockedStatus:
		if(digimon.statusEffect.has(nId)):
			digimon.unapplyStatus(nId)
		digimon.statusImunity.append(nId)

func unapplyingEffect(digimon: Digimon) -> void:
	for nId : int in blockedStatus:
		digimon.statusImunity.erase(nId)

func getStatus() -> StatusEffect:
	return Unstoppable.new(self.duration)
