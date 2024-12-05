extends MenuWindow

class_name Config

func _init() -> void:
	self.menuName = "Config"
	self.pastWindow = 0
	self.buttonEdit = {
		0 : ["Language", "res://assets/interface/Icons/InterfaceIcons/menu icons/Language.png"]
	}

#as funções abaixo vão determinar qual janela será aberta
func openLanguage() -> void:
	self.gameMenu.openMenu(2)
