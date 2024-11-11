extends Node2D

class_name QuickInfo
#elementos de cena
@export var closeButton: Button
@export var icon: Sprite2D
@export var content: RichTextLabel
@export var title: Label
#variável de controle fechar/abrir
var cardFont

func _ready() -> void:
	self.visible = false

#funções de exibição e encerramento
func popWindow(nicon: CompressedTexture2D, ntitle: String, ncontent: String, ninfoCard) -> void:
	icon.texture = nicon
	content.text = "[center]" + ncontent + "[/center]"
	cardFont = ninfoCard
	title.text = ntitle
	self.visible = true

func closeWindow() -> void:
	if(cardFont.has_method("unblockAllButtons")):
		cardFont.unblockAllButtons()
		self.visible = false
	else:
		print("ERRO: Invalid card font")

func popEquipWindow(equip: Equipment, ninfocard) -> void:
	var equipDescription: String = tr(StringName(equip.itemDescription))
	for i in range(equip.attBuffs.size()):
		if(equip.attBuffs[i] > 0):
			var addString: String = "\n" + tr(StringName(equip.buffAdress[i].to_upper())) + ": +" + str(equip.attBuffs[i])
			equipDescription += addString
		elif(equip.attBuffs[i] < 0):
			var addString: String = "\n" + tr(StringName(equip.buffAdress[i].to_upper())) + ": " + str(equip.attBuffs[i])
			equipDescription += addString
	if(equip.itemPassives.size() > 0):
		equipDescription += "\n" + tr(StringName("Passives"))
		for newPassive: PassiveSkill in equip.itemPassives:
			var addString: String = "\n" + tr(StringName(newPassive.skillName))
			equipDescription += addString
	popWindow(equip.itemIcon, tr(equip.itemName), equipDescription, ninfocard)
