extends Tamer

class_name Player

#scene elements
@export var buttonPanel : ButtonPanel

func _ready() -> void:
	self.tamerName = "Player"
	#setando o damage shower
	turnFrame.visible = false
	summonDigimon(0)
	#teste de habilidades ativas.
	digimon.learnSkill(BasicAtack.new())
	digimon.learnSkill(CureI.new())
	digimon.learnSkill(WillfullIgnorance.new())
	digimon.learnSkill(LimiterRemoval.new())
	digimon.learnSkill(LuminousLash.new())
	#teste de habilidades passivas
	#teste de status effect
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
