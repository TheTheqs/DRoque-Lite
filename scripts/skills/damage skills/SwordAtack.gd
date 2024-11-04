extends BasicAtack

class_name SwordAtack
#sangramento aplicado

func _init():
	self.skillData = load("res://resources/skills/DamageSkills/SwordAtack.tres")
	self.isSlow = true
	setStats(skillData)
#aplicação do sangramento
func applyStats(digimon: Digimon) -> void:
	digimon.applyStatus(Bleed.new(1))
