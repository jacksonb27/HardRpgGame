//
// Fragment shader with wave effect
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;      // time in seconds
uniform float u_strength;  // wave strength (e.g., 0.02)
uniform float u_frequency; // wave frequency (e.g., 10.0)

void main()
{
    // Apply sine wave to X coordinate based on Y position and time
    float offset = sin((v_vTexcoord.y + u_time) * u_frequency) * u_strength;
    vec2 waved_uv = vec2(v_vTexcoord.x + offset, v_vTexcoord.y);
    
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, waved_uv);
}
