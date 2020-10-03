shader_type canvas_item;
render_mode unshaded;

uniform float blur_amount : hint_range(0.0, 5.0);

void fragment() {
	COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);
}