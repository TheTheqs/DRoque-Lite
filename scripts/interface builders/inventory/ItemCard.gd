extends Control

class_name ItemCard
#características
var relatedItem: Item
var relatedInventory: InventoryDisplay
var nicon: CompressedTexture2D
var ntitle: String
var ncontent: String
#elementos de cena
@export var itemFrame: Sprite2D
@export var icon: Sprite2D
@export var quantity: Label
@export var button: Button
@export var showDesc: Timer
#frame dick
var frames: Dictionary = {
	0 : preload("res://assets/interface/Icons/item icons/UsableItemFrame.png"),
	1 : preload("res://assets/interface/Icons/item icons/EquipmentFrame.png"),
	2 : preload("res://assets/interface/Icons/item icons/MiscFrame.png")
}

func buildCard(item: Item, inventory: InventoryDisplay) -> void:
	relatedItem = item
	relatedInventory = inventory
	nicon = item.itemIcon
	ntitle = item.itemName
	ncontent = item.itemDescription 
	relatedInventory.allButtons.append(self.button)
	if(item.isMisc):
		itemFrame.texture = frames[2]
	elif(item is UsableItem):
		itemFrame.texture = frames[0]
	icon.texture = item.itemIcon
	quantity.text = str(item.quantity)
	self.visible = true

func startDescTimer() -> void:
	showDesc.stop()
	showDesc.start(0.5)

func showDescription() -> void:
	relatedInventory.showItemDescription(nicon, ntitle, ncontent)

func buttonUp() -> void:
	if(!showDesc.is_stopped()):
		showDesc.stop()
		relatedInventory.useItem(relatedItem)
