shader_type canvas_item;

uniform float intensity : hint_range(0, 1); // Controle de intensidade.

void fragment() {
    vec2 uv = UV; // Coordenadas normalizadas do sprite.
    vec4 color = texture(TEXTURE, uv); // Cor original do pixel, agora usando `uv`.

    // Efeito glitch só ocorre se a intensidade for maior que 0
    if (intensity > 0.0) {
        float offset = sin(TIME * 10.0) * intensity * 0.05;
        vec2 glitch_uv = vec2(uv.x + offset, uv.y); // Usando `uv` para deslocamento.

        float glitch_r = texture(TEXTURE, glitch_uv + vec2(0.02, 0.0)).r;
        float glitch_g = texture(TEXTURE, glitch_uv + vec2(-0.02, 0.01)).g;
        float glitch_b = texture(TEXTURE, glitch_uv + vec2(0.0, -0.01)).b;

        float glitch_line = step(0.95, fract(uv.y * 50.0)) * 0.2; // Usando `uv` para as linhas.
        color.rgb = vec3(glitch_r, glitch_g, glitch_b) + glitch_line * intensity;
    }

    COLOR = color; // Resultado final.
}