extends Sprite2D
#essa classe encapsula a manipulação do shader material, tranformando ele em uma classe manipulável pelos princípios da OOP
class_name GlitchShader
#a variável abaixo representa o shader atrelado ao nó em cena
var shaderMaterial: ShaderMaterial
#função ready para atrelar o material
func _ready() -> void:
	if(self.material and self.material is ShaderMaterial):
		self.shaderMaterial = self.material
	else:
		print("Error! Material is not a shader")
#a função abaixo liga e desliga o efeito glitch
func setGlitchEffect(choice: bool) -> void:
	if(self.shaderMaterial):
		if(choice):
			self.shaderMaterial.set_shader_parameter("intensity", 1.0)
		else:
			self.shaderMaterial.set_shader_parameter("intensity", 0.0)
	else:
		print("ERROR! Shader Material is null")
