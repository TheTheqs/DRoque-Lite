extends Control

class_name ReplaceSkills
@export var window: RearrangementWindow
@export var skillButtons: Array[ButtonDescription]
@export var showTimer: Timer
var skillToBeLearned: Skill
#controle de exibição
var currentIndex: int
var onShow: bool = false
#função principal de amostragem
func settButtons(array: Array) -> void:
	self.window.allButtons.clear()
	self.window.allButtons.append(self.window.closeButton)
	if(array.size() == 4):
		for i: int in range(array.size() -1):
			if(array[i] is Skill):
				skillButtons[i].associateSkill(array[i])
		self.skillToBeLearned = array[3]
	else:
		print("ERROR: Invalid array!")
		return
	self.window.allButtons.append_array(self.skillButtons)
	self.visible = true

func activateShowDesc() -> void:
	self.onShow = true
	self.window.showSkillDesc(self.skillButtons[self.currentIndex].relatedSkill)

func onSkill0ButtonDown():
	self.onShow = false
	self.currentIndex = 0
	self.showTimer.start(0.5)

func onSkill1ButtonDown():
	self.onShow = false
	self.currentIndex = 1
	self.showTimer.start(0.5)

func onSkill2ButtonDown():
	self.onShow = false
	self.currentIndex = 2
	self.showTimer.start(0.5)

func tryConfirmation() -> void:
	self.showTimer.stop()
	if(!self.onShow):
		self.window.triggerConfirmation(self.skillButtons[self.currentIndex].relatedSkill.skillName)

func finishingSelection() -> void:
	self.window.currentSkillArray[self.currentIndex] = skillToBeLearned
	self.window.currentSkillArray.remove_at(3)
	self.window.endSelection()
