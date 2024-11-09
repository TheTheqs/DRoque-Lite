extends Tamer

class_name Player

#scene elements
@export var buttonPanel : ButtonPanel
@export var inventoyDisplay: InventoryDisplay
func _ready() -> void:
	Campaign.loadContent() #essa é apenas uma função de testes
	self.tamerReference = Campaign
	var choice: int = Campaign.playerCurrentChoice
	self.tamerName = "Player"
	self.tamerLevel = Campaign.playerLevel
	#setando o damage shower
	turnFrame.visible = false
	#colcoando o mostro escolhido em cena
	self.digimon.setStats(choice)
	#adicionando inventário
	if(Util.checkArray(Campaign.playerInventory)):
		for item: Item in Campaign.playerInventory:
			self.inventory.addItem(item, item.quantity)
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	buttonPanel.setButtons()
	buttonPanel.updateButtons()
	judge.gettingStarted()

func onFrameAnimation(anim_name: String):
	if(anim_name == "blinkFrame"):
		self.canAct = true
		BM.showMessage(tr(StringName("BattleMessage2a")))

func actionsAnimation(anim_name: String) -> void:
	if(anim_name == "blinkActions"):
		actionsDisplay.visible = true
