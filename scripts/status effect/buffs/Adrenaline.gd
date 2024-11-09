extends StatusEffect

class_name Adrenaline
var bonuses: Array[int] = [1, 1, 1, 1, 1, 1]
var adresses: Array[String] = ["str", "int", "agi", "vit", "wis", "dex"]
var maxBuffs: Dictionary = {
	0 : 15,
	1 : 30,
	2 : 50,
	3 : 80
}
#value
func _init() -> void:
	self.statusId = 31
	self.statusIcon = preload("res://assets/interface/Icons/InterfaceIcons/status effect icons/Adrenaline.png")
	self.setStats()
	self.statusType = Enums.StatusType.BUFF

func applyingEffect(digimon: Digimon) -> void:
	self.buildBuffs(digimon)
	for i : int in range(bonuses.size()):
		digimon.changeBonusAttribute(adresses[i], bonuses[i])


func unapplyingEffect(digimon: Digimon) -> void:
	if(digimon.statusEffect.has(self.statusId)):
		var oldAdrenaline: Adrenaline = digimon.statusEffect[self.statusId]
		for i : int in range(oldAdrenaline.bonuses.size()):
			digimon.changeBonusAttribute(oldAdrenaline.adresses[i], -oldAdrenaline.bonuses[i])

func getStatus() -> StatusEffect:
	return Adrenaline.new()

func buildBuffs(digimon: Digimon) -> void:
	# Inicializa uma quantidade de pontos para distribuir
	var remainingBuffs = maxBuffs[digimon.digimonTier]
	while remainingBuffs > 0:
		var randomAttribute = Util.pickOne(adresses)
		var index = adresses.find(randomAttribute)
		var buffValue = Util.random(1, min(remainingBuffs, 3))
		bonuses[index] += buffValue
		remainingBuffs -= buffValue

func getAditionalDescription() -> String:
	var string: String = ""
	for i : int in range(bonuses.size()):
		string += "\n" + tr(StringName(adresses[i].to_upper())) + " +" +str(bonuses[i])
	return string
