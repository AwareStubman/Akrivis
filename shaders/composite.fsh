#version 330

// Vertex shader inputs
in vec2 fTexCoord;

// Uniform buffer samplers
uniform sampler2D colortex0;

// Depth buffer sampler(s)
uniform sampler2D depthtex0;

/* RENDERTARGETS: 0 */
layout (location = 0) out vec4 mainBuffer;

/*
Change format as needed
*/
/*
const int colortex0Format = RGBA16F;
const int colortex10Format = R11F_G11F_B10F;
*/

// We will now do 5 bloom tiles

void main()
{
    vec3 color = texture(colortex0, fTexCoord).rgb;

    if (texture(depthtex0, fTexCoord).r >= 1.0)
        // Pixel is in sky
        color = pow(color, vec3(2.2)); // sRGB to linear

    mainBuffer = vec4(color, 1.0);
}