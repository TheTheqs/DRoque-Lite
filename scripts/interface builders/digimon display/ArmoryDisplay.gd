extends Node

class_name ArmoryDisplay
#botões em tela
@export var equipmentButtons: Array[EquipDisplayButton]
#dicionário de ícones vazios
var blanckIcons: Dictionary = {
	0 : preload("res://assets/interface/Icons/item icons/BlankWeapon.png"),
	1 : preload("res://assets/interface/Icons/item icons/BlankOffHand.png"),
	2 : preload("res://assets/interface/Icons/item icons/BlankBody.png"),
	3 : preload("res://assets/interface/Icons/item icons/BlankAcessory.png"),
}

func buildIcons(armory: Array) -> void:
	for i in range(armory.size()):
		if(armory[i] != null and armory[i] is Equipment):
			equipmentButtons[i].buildButton(armory[i])
		else:
			equipmentButtons[i].icon.texture = blanckIcons[i]
		equipmentButtons[i].selfDesc = i

func resetEquipButtons() -> void:
	for equipBut : EquipDisplayButton in equipmentButtons:
		equipBut.relatedEquipment = null
