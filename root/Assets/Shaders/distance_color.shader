shader_type spatial;

uniform float max_distance = 20.0;
varying float z_dist;

void vertex() {
	z_dist = clamp((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).z * -1.0,0.0, max_distance) / max_distance; // from 20.0 to 0.0
}

void fragment() { 
	ALBEDO = vec3(0.5-(z_dist*0.4));
}