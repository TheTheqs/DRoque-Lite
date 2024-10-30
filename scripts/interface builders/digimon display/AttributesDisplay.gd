extends Node2D

class_name AttributesDisplay
#elementos de cena
@export var attributes: Label
#elementos de construção
var baseSTR: int
var bonusSTR: int
var baseINT: int
var bonusINT: int
var baseAGI: int
var bonusAGI: int
var baseVIT: int
var bonusVIT: int
var baseWIS: int
var bonusWIS: int
var baseDEX: int
var bonusDEX: int
var attributeString: Array[String] = ["STR", "INT", "AGI", "VIT", "WIS", "DEX"]
#função que integra os elementos e muda a interface
func showContent(digimon: Digimon) -> void:
	for attString: String in attributeString:
		self.set(("base" + attString), digimon.get(("base" + attString)))
		self.set(("bonus" + attString), digimon.get(("bonus" + attString)))
	self.attributes.text = ""
	for attString: String in attributeString:
		var stringToAdd: String = "%s:%d(%d)\n" % [tr(StringName(attString)), self.get("base" + attString), self.get("bonus" + attString)]
		self.attributes.text += stringToAdd
