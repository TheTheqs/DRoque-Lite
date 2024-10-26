extends Node

class_name Translator
#manter o valor abaixo sempre atualizado! ele representa o número de msgs no banco de dados
var currentMessageSize: int = 118
#lista de documentos referência
var languages: Dictionary = {
	"en" : "res://translation/enUS.tres",
	"pt" : "res://translation/ptBR.tres"
}
#paths para arquivos jSON de configuração
var configLogPath: Dictionary = {
	"en" : "res://translation/enUS.json",
	"pt" : "res://translation/ptBR.json"
}
#variável referência da língua atual
var currentLanguage: String
var currentDictionary: Translation

func _ready() -> void:
	if(not currentLanguage):
		changeLanguage("pt")

func changeLanguage(newLanguage: String) -> void:
	if (newLanguage in languages):
		currentLanguage = newLanguage
		currentDictionary = load(languages[currentLanguage])
		
		if(currentDictionary and currentDictionary.get_message_count() < currentMessageSize):
			translationConfig()
		
		#estabelecer dicionário
		setTranslator()
	else:
		print("Not a valid language!")

func translationConfig() -> void:
	var filePath: String = configLogPath[currentLanguage]
	var file = FileAccess.open(filePath, FileAccess.READ)
	if(file):
		var jsonText = file.get_as_text()
		file.close()
		var jsonData: Dictionary = JSON.parse_string(jsonText)
		if(jsonData and jsonData.size() > 0):
			var currentDictionaryKeys: PackedStringArray = currentDictionary.get_message_list()
			for key in jsonData.keys():
				if (!currentDictionaryKeys.has(key)):
					currentDictionary.add_message(StringName(key), jsonData[key])
			#salva as alterações de forma permanente
			saveTranslation() 
		else:
			print("Empty or Invalid JSON")
	else:
		print("Error opening file: ", filePath)

func saveTranslation() -> void:
	ResourceSaver.save(currentDictionary, languages[currentLanguage])

func setTranslator() -> void:
	TranslationServer.add_translation(currentDictionary)
	TranslationServer.set_locale(currentLanguage)
