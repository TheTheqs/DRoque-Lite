extends Node

class_name DamageShower
#Elementos de Cena
@export var damageToShow: RichTextLabel
@export var showTimer: Timer
@export var BTM: BattleManager
@export var relatedTamer: Tamer
#Variáveis de controle
var inicitialPosition: Vector2
var showing: bool = false
var damagesToShow: Array[DamageData]
var speed: float = 1.3
var modulateSpeed: float = 0.008
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
		queueSweep()
	else:
		damagesToShow.append(damageData)

func updateDamage() -> void:
	var outlineColor: String = damageColor[damagesToShow[0].damageElement]
	if(not damagesToShow[0].isCritic):
		damageToShow.text = "[center][font_size=16][outline_color=#"+ outlineColor +"]" + str(Util.cap(damagesToShow[0].damageValue)) + "[/outline_color][/font_size][/center]"
	else:
		damageToShow.text = "[center][font_size=32][outline_color=#"+ outlineColor +"]" + str(Util.cap(damagesToShow[0].damageValue)) + "[/outline_color][/font_size][/center]"
	self.visible = true
	damagesToShow.remove_at(0)
	set_process(true)

func _ready() -> void:
	set_process(false)
	self.visible = false
	

func _process(_delta) -> void:
	if(self.position.y > positionLimit):
		if(self.position.y - speed <= positionLimit):
			self.position.y = positionLimit
		else:
			self.position.y -= speed
	if(self.modulate.a > 0):
		if(self.modulate.a - modulateSpeed <= 0):
			self.modulate.a = 0
		else:
			self.modulate.a -= modulateSpeed
	if(self.modulate.a == 0):
		self.visible = false
		self.position = inicitialPosition
		self.modulate.a = 1.0
		queueSweep()

func queueSweep() -> void:
	if(damagesToShow.size() > 0):
		updateDamage()
	else:
		showing = false
		set_process(false)
		BTM.outAction("Damage Shower")
