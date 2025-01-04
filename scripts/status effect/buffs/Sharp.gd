extends StatusEffect

class_name Sharp
#value
func _init() -> void:
	self.statusId = 21
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Sharp.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF

func getStatus() -> StatusEffect:
	return Sharp.new()
