extends Node

class_name EvolutionChart
#Identificação
var relatedDigimon: Digimon
#triggers
var activated: bool = false
var trigger: Trigger
#classe que ativa a evolução
var evolutioner: Evolver = Evolver.new()

func setting(digimon) -> void:
	self.relatedDigimon = digimon
	self.arrangeTriggers(digimon)
#função que aloca os trigers devidamente. Essa função deve ser sobreescrita
func arrangeTriggers(_digimon: Digimon) ->void:
	pass
#chama a evolução
func activateEvolution(newIndex: int) -> void:
	if(not activated):
		self.activated = true
		self.evolutioner.currentIndex = newIndex
		relatedDigimon.actionsToGo.append(evolutioner)
	
