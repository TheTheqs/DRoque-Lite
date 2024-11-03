extends Control

class_name EquipDisplayButton
#classe que constrói o botão de exibição de equipamentos no display
var relatedEquipment : Equipment = null
@export var display: DigimonDisplay
@export var icon: Sprite2D
#dicionário de descrição
var descDic : Dictionary = {
	0 : "NoWeapon",
	1 : "NoOffHand",
	2 : "NoArmor",
	3 : "NoAccessory",
}
var selfDesc: int
#função de construção
func buildButton(equip: Equipment) -> void:
	self.relatedEquipment = equip
	self.icon.texture = equip.itemIcon

func showInfo() -> void:
	if(relatedEquipment == null):
		display.quickWindow.popWindow(icon.texture, tr(StringName("Unequiped")), tr(StringName(descDic[selfDesc])), display)
	else:
		display.showEquipWindow(relatedEquipment)
