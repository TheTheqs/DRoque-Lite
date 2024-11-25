extends EvolutionChart
#Dorumon evolution charts
class_name DorumonEC

func _init(digimon: Digimon) -> void:
	self.trigger = DorumonECT.new(self)
	self.setting(digimon)

func arrangeTriggers(digimon: Digimon) ->void:
	digimon.onDamageDelt.append(self.trigger)

func unsetting(digimon: Digimon)-> void:
	digimon.onDamageDelt.erase(self.trigger)
