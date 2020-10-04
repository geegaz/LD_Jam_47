shader_type canvas_item;

uniform float time = 0.0;
uniform float amount = 0.0;
const float PI = 3.14159;

void vertex() {
	VERTEX = VERTEX*(1.0+sin(time*2.0*PI)*amount);
}