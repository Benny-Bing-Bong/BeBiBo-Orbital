shader_type canvas_item;

global uniform bool invert_projectile;

void fragment() {
	if (invert_projectile == true) {
	COLOR.rgb = 1.0 - COLOR.rgb;
	}
}