shader_type canvas_item;
render_mode unshaded;

uniform bool blink = false;
uniform float blink_speed = 1.0;
uniform float speed: hint_range(0.0,100.0) = 0.0;

void vertex() {
	VERTEX.y -= -(1.0-UV.y)*sin(TIME*speed)*15.0;
}

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	if(blink && sin(TIME*blink_speed) > 0.0) col.a = 0.0;
	COLOR = col;
}