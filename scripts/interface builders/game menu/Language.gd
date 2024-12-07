extends MenuWindow

class_name Language
#elementos exclusivos dessa classe
@export var currentLanguageText: Label
@export var flag: Sprite2D
var currentLanguage: int 
var choiceLanguage: Array = ["en", 0]
func _init() -> void:
	self.menuName = "Language"
	self.pastWindow = 1
	self.buttonEdit = {
		0 : ["en", "res://assets/interface/Icons/InterfaceIcons/menu icons/enUSflag.png"],
		1 : ["pt", "res://assets/interface/Icons/InterfaceIcons/menu icons/ptBRflag.png"]
	}


func _ready() -> void:
	for key: int in self.buttonEdit:
		if(self.buttonEdit[key][0] == TTR.currentLanguage):
			self.currentLanguage = key


#funções de interação com as opções
func ptSelected() -> void:
	if(self.currentLanguage != 1):
		self.choiceLanguage = ["pt", 1]
		self.askPermition()

func usSelected() -> void:
	if(self.currentLanguage != 0):
		self.choiceLanguage = ["en", 0]
		self.askPermition()

#as funções abaixo vão determinar a função para cada botão
func afterBuild() -> void:
	self.currentLanguageText.text = tr(StringName("CLang")) + "\n" + tr(StringName(self.buttonEdit[self.currentLanguage][0]))
	self.flag.texture = load(self.buttonEdit[self.currentLanguage][1])

#função que de fato muda a língua do jogo
func changeLanguage() -> void:
	TTR.changeLanguage(self.choiceLanguage[0])
	self.currentLanguage = self.choiceLanguage[1]
	self.gameMenu.openMenu(-1)

#função de interação com a janela de requisição de confirmação
func confirmation(confirm: bool) -> void:
	if(confirm):
		self.changeLanguage()
		self.gameMenu.BTM.updateInterface()
	self.manageBlockUnblock(false)

func askPermition() -> void:
	self.manageBlockUnblock(true)
	self.gameMenu.confimWindow.requireConfirmation(tr(StringName("CLangChange")) + tr(StringName(self.choiceLanguage[0])) + "?", self)

func manageBlockUnblock(command: bool) -> void:
	for button: Button in self.allButtons:
		button.disabled = command
	self.gameMenu.closeButton.disabled = command
	self.gameMenu.backButton.disabled = command
