extends Button

class_name ButtonDescription
#classe feita para descrever e associar um botão com algo
var buttonName: String
var buttonDescription: String
var isSkillButton: bool
var relatedSkill: Skill

func associateSkill(skill: Skill) -> void:
	if(skill != null):
		buttonName = skill.skillName
		buttonDescription = skill.skillDescritption
		relatedSkill = skill
		self.icon = skill.skillIcon

func updateSkills() -> void:
	if(relatedSkill != null):
		if(not relatedSkill.usable):
			self.disabled = true
		else:
			self.disabled = false
		if(relatedSkill.currentCooldown != 0):
			self.text = str(relatedSkill.currentCooldown)
		else:
			self.text = ""
