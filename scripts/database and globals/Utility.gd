extends Node

class_name Utility
#Type convert
var convertType: Dictionary = {
	Enums.Type.VIRUS : "0",
	Enums.Type.VACCINE : "1",
	Enums.Type.DATA: "2",
	Enums.Type.FREE: "3",
	Enums.Type.SPECIAL: "4"
}
#type ratio
var typeRatio: Dictionary = {
	"02" : 1.3,
	"20" : 0.7,
	"21" : 1.3,
	"12" : 0.7,
	"10" : 1.3,
	"01" : 0.7
}
#element convert
var convertElement: Dictionary = {
	Enums.Element.FIRE : "0",
	Enums.Element.WATER : "1",
	Enums.Element.PLANT : "2",
	Enums.Element.EARTH : "3",
	Enums.Element.THUNDER : "4",
	Enums.Element.WIND : "5",
	Enums.Element.LIGHT : "6",
	Enums.Element.DARK : "7",
	Enums.Element.NEUTRAL : "8"
}
#element ratio
var elementRatio: Dictionary = {
	"01" : 0.7,
	"10" : 1.3,
	"20" : 0.7,
	"02" : 1.3,
	"12" : 0.7,
	"21" : 1.3,
	"54" : 0.7,
	"45" : 1.3,
	"35" : 0.7,
	"53" : 1.3,
	"43" : 0.7,
	"34" : 1.3,
	"67" : 1.3,
	"76" : 1.3,
}
#Get a random number
func random(minn: int, maxn: int) -> int:
	return randi_range(minn, maxn)

#retorna true ou false baseado em uma chance
func chance(nchance: float) -> bool:
	if (nchance >= 100):
		return true
	var randomValue = randf() * 100
	return (randomValue <= nchance)
#função que capa números float, para que eles tenham apenas 2 casa decimais
func cap(value: float) -> float:
	return round(value*100)/100
#função que capa números float, para que eles tenham apenas 2 casa decimais
func hardCap(value: float) -> float:
	return round(value*10)/10

#cria um damage data baseado em uma skill
func damageDataBuilder(damageSkill: DamageSkill) -> DamageData:
	var newDamageData : DamageData = DamageData.new()
	newDamageData.buildData(damageSkill, damageSkill.damageType, damageSkill.damageSubType, damageSkill.element, damageSkill.atackerType, damageSkill.damageValue, damageSkill.isCritic)
	return newDamageData

func getProportion(portion: float, whole: float) -> float:
	return self.cap(portion/whole)

func getElementRatio(atacker: Enums.Element, defender: Enums.Element) -> float:
	var elementConvert: String = str(convertElement[atacker] + convertElement[defender])
	if (elementRatio.has(elementConvert)):
		return elementRatio[elementConvert]
	else:
		return 1.0

func getTypeRatio(atacker: Enums.Type, defender: Enums.Type) -> float:
	var typeConvert: String = str(convertType[atacker], convertType[defender])
	if(typeRatio.has(typeConvert)):
		return typeRatio[typeConvert]
	else:
		return 1.0

func pickOne(options: Array) -> Variant:
	if(options.size() > 0):
		var selectedIndex: int = random(0, (options.size() -1))
		return options[selectedIndex]
	else:
		print("ERROR: Invalid options!")
		return null

func clearChildren(node: Node) -> void:
	if(node.get_child_count() > 0):
		for child in node.get_children():
			child.queue_free()

func updateMaxHealthMana(digimon: Digimon, value: float, isMana: bool) -> void:
	var currentDigimonProportion: float 
	if(isMana):
		currentDigimonProportion = self.getProportion(digimon.currentMana, digimon.maxMana)
		if(digimon.maxMana + value <= 0):
			print("ERROR: Negative max helth")
		else:
			digimon.maxMana += value
			digimon.currentMana = digimon.maxMana*currentDigimonProportion
	else:
		currentDigimonProportion = self.getProportion(digimon.currentHealth, digimon.maxHelth)
		if(digimon.maxHelth + value <= 0):
			print("ERROR: Negative max helth")
		else:
			digimon.maxHelth += value
			digimon.currentHealth = self.cap(digimon.maxHelth*currentDigimonProportion)
#função que verifica se um array é válido para uso
func checkArray(array: Array) -> bool:
	if(array != null and array.size() > 0):
		return true
	else:
		return false

func getValidParty(digimon: Digimon) -> Array:
	var partyDic: Dictionary = digimon.tamer.tamerReference.playerParty
	var validParty: Array = []
	for key: int in partyDic:
		if(partyDic[key] != null):
			validParty.append(key)
	return validParty
#função que retorna o index de um elemento vazio em um array. Retorna -1 caso nao haja elementos vazios.
func emptySlot(array: Array) -> int:
	for i: int in range(array.size()):
		if(array[i] == null):
			return i
	return -1
