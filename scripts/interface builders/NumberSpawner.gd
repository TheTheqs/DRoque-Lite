extends Node

class_name NumberSpawner
#Cena estática de número spawnado
var spawn: PackedScene = preload("res://scenes/entities/SpawnedNumber.tscn")

var elementColor: Dictionary = {
	Enums.Element.NEUTRAL : "A5A5A5",
	Enums.Element.FIRE : "E60000",
	Enums.Element.PLANT : "008300",
	Enums.Element.WATER : "008486",
	Enums.Element.THUNDER : "FFFF3A",
	Enums.Element.EARTH : "7D4900",
	Enums.Element.WIND : "65A49B",
	Enums.Element.LIGHT : "FFFFA5",
	Enums.Element.DARK : "5B315B",
	}

var statusColor: Dictionary = {
	Enums.StatusType.BUFF : "FFFF00",
	Enums.StatusType.DEBUFF : "FF4200"
}

var healColor: Dictionary = {
	true: "64A5FF",
	false: "51FF00"
}

func spawnContent(content) -> void:
	var contentToShow: String
	if(content is DamageData):
		contentToShow = processDamageData(content)
	elif(content is StatusEffect):
		contentToShow = processStatus(content)
	elif(content is String):
		contentToShow = processString(content)
	elif(content is HealData):
		contentToShow = processHealData(content)
	var newSpawn: SpawnedNumber = spawn.instantiate()
	self.call_deferred("add_child", newSpawn)
	newSpawn.showNumber(contentToShow)

func processDamageData(damageData: DamageData) -> String:
	var outlineColor: String = elementColor[damageData.damageElement]
	var newString: String = ""
	if(damageData.isCritic):
		newString = "\n[center][outline_size=4][font_size=16][outline_color=#" + outlineColor + "]" +str(Util.cap(damageData.damageValue)) + "[/outline_color][/font_size][/outline_size][/center]"
	else:
		newString = "\n[center][outline_size=4][font_size=8][outline_color=#" + outlineColor + "]" +str(Util.cap(damageData.damageValue)) + "[/outline_color][/font_size][/outline_size][/center]"
	return newString

func processStatus(statusEffect: StatusEffect) -> String:
	var outlineColor: String = statusColor[statusEffect.statusType]
	var newString: String = ""
	newString = "\n[center][outline_size=8][font_size=8][outline_color=#" + outlineColor + "]" + statusEffect.statusName + "[/outline_color][/font_size][/outline_size][/center]"
	return newString

func processString(string: String) -> String:
	var newString: String = "\n[center][outline_size=8][font_size=8][outline_color=#64A5FF]" + string + "[/outline_color][/font_size][/outline_size][/center]"
	return newString

func processHealData(healData: HealData) -> String:
	var outlineColor: String = healColor[healData.isMana]
	var newString: String = ""
	newString = "\n[center][outline_size=8][font_size=16][outline_color=#" + outlineColor + "]" + str(Util.cap(healData.healValue)) + "[/outline_color][/font_size][/outline_size][/center]"
	return newString
