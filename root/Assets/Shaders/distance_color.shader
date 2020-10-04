shader_type spatial;

uniform vec4 color_far: hint_color = vec4(vec3(0.0),1.0);
uniform vec4 color_near: hint_color = vec4(1.0);
uniform float max_distance = 20.0;
uniform int steps: hint_range(0, 256) = 0;

varying float z_dist;

void vertex() {
	z_dist = clamp((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).z * -1.0,0.0, max_distance) / max_distance; // from 20.0 to 0.0
	// z_dist stores a value between 0.0 and 1.0
}

void fragment() {
	float mixer = z_dist;
	if(steps > 0) { //if the number of steps is > 0, divide the color in steps
		mixer = floor(z_dist/(1.0/float(steps)))*(1.0/max_distance);
	}
		
	vec3 color = mix(color_near, color_far, mixer).rgb;
	ALBEDO = color;
}