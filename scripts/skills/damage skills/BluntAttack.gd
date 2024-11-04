extends BasicAtack

class_name BluntStrike
#sangramento aplicado

func _init():
	self.skillData = load("res://resources/skills/DamageSkills/BluntStrike.tres")
	setStats(skillData)
#aplicação do sangramento
func applyStats(digimon: Digimon) -> void:
	var vitDebuff: int = min(digimon.enemy.currentLevel, 10)
	digimon.applyStatus(VitMinus.new(vitDebuff))
