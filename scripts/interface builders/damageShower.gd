extends Node


class_name DamageShower
#Elementos de Cena
@export var damageToShow: RichTextLabel
@export var showTimer: Timer
#Variáveis de controle
var inicitialPosition: int
var showing: bool = false
var damagesToShow: Array[DamageData]
var speed: float = 1.2
var modulateSpeed: float = 0.08
var positionLimit: int
#Cores para borda.
var damageColor: Dictionary = {
	Enums.Element.NEUTRAL : "A5A5A5",
	Enums.Element.FIRE : "FF4200",
	Enums.Element.WATER : "008486",
	Enums.Element.PLANT : "008300",
	Enums.Element.EARTH : "7D4900",
	Enums.Element.WIND : "64A5FF",
	Enums.Element.THUNDER : "FFFF00",
	Enums.Element.LIGHT : "FFFFA5",
	Enums.Element.DARK : "5B315B"
}

func showDamage(damageData: DamageData) -> void:
	if(not showing):
		BTM.inAction()
		showing = true
		damagesToShow.append(damageData)
	else:
		damagesToShow.append(damageData)

func updateDamage() -> void:
	var outlineColor: String = damageColor[damagesToShow[0].Element]
	if(not damagesToShow[0].isCritic):
		damageToShow.text = "[center][outline_size=5][font_size=8][outline_color= #" + outlineColor + "]" + str(Util.cap(damagesToShow[0].damageValue)) + "[/outline_color][/font_size][outline_size][/center]"
	else:
		damageToShow.text = "[center][outline_size=6][font_size=16][outline_color= #" + outlineColor + "]" + str(Util.cap(damagesToShow[0].damageValue)) + "[/outline_color][/font_size][outline_size][/center]"
	damageToShow.visible = true
	damagesToShow.remove_at(0)
	set_process(true)

func _ready() -> void:
	self.visible = false
	inicitialPosition = self.position.y
	positionLimit = inicitialPosition - 65

func _process(_delta) -> void:
	if(damageToShow.position.y > positionLimit):
		if(damageToShow.position.y - speed <= positionLimit):
			damageToShow.position.y = positionLimit
		else:
			damageToShow.position.y -= speed
	if(self.modulate.a > 0):
		if(self.modulate.a - modulateSpeed <= 0):
			self.modulate.a = 0
		else:
			self.modulate.a -= modulateSpeed
	if(self.modulate.a == 0):
		self.visible = false
		damageToShow.position.y = inicitialPosition
		self.modulate.a = 1.0
		queueSweep()

func queueSweep() -> void:
	if(damagesToShow.size() > 0):
		updateDamage()
	else:
		showing = false
		BTM.outAction()
