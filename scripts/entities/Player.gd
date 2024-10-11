extends Tamer

class_name Player

#scene elements
@export var buttonPanel : ButtonPanel

func _ready() -> void:
	self.tamerName = "Player"
	#setando o damage shower
	turnFrame.visible = false
	summonDigimon(Util.random(0, 5))
	#teste de habilidades.
	digimon.learnSkill(BasicAtack.new())
	#atualização da interface. Sempre a última coisa a se fazer!
	HUDD.updateValues()
	buttonPanel.setButtons()
	buttonPanel.updateButtons()
	judge.gettingStarted()

func onFrameAnimation(anim_name: String):
	if(anim_name == "blinkFrame"):
		self.canAct = true
		BM.showMessage(tr(StringName("BattleMessage2a")))
