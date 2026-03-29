shader_type canvas_item;
uniform float scale = 0;
uniform float alpha = 0;
uniform vec3 end = vec3(1, -1, -1);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR += vec4(scale*(end-vec3(COLOR.r,COLOR.g,COLOR.b)), COLOR.a-(alpha+1.0));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
