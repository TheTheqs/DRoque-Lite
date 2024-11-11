extends Node

class_name InventoryDisplay
#elementos da cena
@export var title: Label
@export var closeButton: Button
@export var buttonPanel: ButtonPanel
@export var relatedPlayer: Tamer
@export var buildTimer: Timer
@export var itemList: GridContainer
@export var infoWindow: QuickInfo
#referências
var currentInventory: Inventory
var allButtons: Array[Button]
var itemCard: PackedScene = preload("res://scenes/entities/ItemCard.tscn")
var newItems: Array

func _ready():
	self.visible = false
#funções de abertura e ecnerramento
func opening() -> void:
	buttonPanel.blockAllButtons()
	title.text = tr(StringName("Inventory"))
	resetInventory()
	self.visible = true


func closing() -> void:
	self.visible = false
	buttonPanel.unBlockAllButtons()

func resetInventory() -> void:
	self.currentInventory = relatedPlayer.inventory
	Util.clearChildren(itemList)
	allButtons.clear()
	newItems.clear()
	newItems = currentInventory.getInventory()
	buildTimer.call_deferred("start", 0.1)

func buildList() -> void:
	for item: Item in newItems:
		var newCard: ItemCard = itemCard.instantiate()
		newCard.buildCard(item, self)
		itemList.call_deferred("add_child", newCard)

func showItemDescription(nicon: CompressedTexture2D, ntitle: String, ncontent: String) -> void:
	blockAllButtons()
	infoWindow.popWindow(nicon, tr(StringName(ntitle)), tr(StringName(ncontent)), self)

func blockAllButtons() -> void:
	if(allButtons.size() > 0):
		for butt : Button in allButtons:
			butt.disabled = true
func unblockAllButtons() -> void:
	if(allButtons.size() > 0):
		for butt : Button in allButtons:
			butt.disabled = false

func useItem(item: Item) -> void:
	if(relatedPlayer.canAct and relatedPlayer.digimon.canUseItem):
		relatedPlayer.canAct = false
		if(item != null):
			relatedPlayer.digimon.chooseAction(ItemUser.new(item))
			relatedPlayer.BTM.choosing = false
			relatedPlayer.BTM.outAction("Inventory")
			currentInventory.removeItem(item, 1)
			self.closing()

func showEquipWindow(equip: Equipment) -> void:
	blockAllButtons()
	infoWindow.popEquipWindow(equip, self)

func forcedClose() -> void:
	self.infoWindow.visible = false
	self.visible = false
