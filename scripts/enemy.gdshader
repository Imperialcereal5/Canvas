shader_type canvas_item;
uniform float scale = 0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR += vec4(scale*vec3(1, -1, -1), COLOR.a);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
