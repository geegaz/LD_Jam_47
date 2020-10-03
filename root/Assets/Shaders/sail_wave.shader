shader_type canvas_item;
render_mode unshaded;

uniform float speed: hint_range(0.0, 10.0) = 0.0;

void vertex() {
	VERTEX.y += UV.x*sin(TIME*speed)*8.0;
}