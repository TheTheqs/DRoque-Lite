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
	"02" : 2.0,
	"20" : 0.5,
	"21" : 2.0,
	"12" : 0.5,
	"10" : 2.0,
	"01" : 0.5
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

#cria um damage data baseado em uma skill
func damageDataBuilder(damageSkill: DamageSkill) -> DamageData:
	var newDamageData : DamageData = DamageData.new()
	newDamageData.buildData(damageSkill.damageType, damageSkill.damageSubType, damageSkill.element, damageSkill.atackerType, damageSkill.damageValue, damageSkill.isCritic)
	return newDamageData

func getProportion(portion: float, whole: float) -> float:
	return portion/whole

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

func pickOne(options: Array) -> Object:
	var selectedIndex: int = random(0, (options.size() -1))
	return options[selectedIndex]
