extends StatusEffect

class_name Root
#construtora
func _init(nDuration: int) -> void:
	self.statusId = 32
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Root.png")
	self.setStats()
	self.isExpirable = true
	self.canCount = true
	self.duration = nDuration
	self.statusType = Enums.StatusType.DEBUFF

func getStatus() -> StatusEffect:
	return Root.new(self.duration)
