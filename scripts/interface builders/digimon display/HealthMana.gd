extends Node2D

class_name HealthMana
#elementos de cena
@export var healthBar: ProgressBar
@export var healthValue: Label
@export var manaBar: ProgressBar
@export var manaValue: Label
#função que atualiza vida e mana
func showDisplay(digimon: Digimon) -> void:
	self.healthBar.max_value = 100
	self.healthBar.value = Util.cap((digimon.currentHealth/digimon.maxHelth)*100)
	self.healthValue.text = formatNumber(digimon.currentHealth) +  "/" + formatNumber(digimon.maxHelth)
	self.manaBar.max_value = 100
	self.manaBar.value = Util.cap((digimon.currentMana/digimon.maxMana)*100)
	self.manaValue.text = formatNumber(digimon.currentMana) + "/" + formatNumber(digimon.maxMana)

func formatNumber(number: float)-> String:
	if(number >= 999999):
		return "999999"
	elif(str(Util.cap(number)).length() > 6):
		if(str(Util.hardCap(number)).length() > 6):
			return str(round(number))
		else:
			return str(Util.hardCap(number))
	else:
		return str(Util.cap(number))
