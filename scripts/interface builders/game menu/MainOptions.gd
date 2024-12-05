extends MenuWindow

class_name MainOptions

func _init() -> void:
	self.menuName = "Menu"
	self.pastWindow = 0
	self.buttonEdit = {
		0 : ["Config", "res://assets/interface/Icons/InterfaceIcons/menu icons/Options.png"]
	}

#as funções abaixo vão determinar qual janela será aberta
func openConfig() -> void:
	self.gameMenu.openMenu(1)
