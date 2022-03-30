#version 330

// Vertex shader inputs
in vec2 fTexCoord;

// Uniform buffer samplers
uniform sampler2D colortex0; // main buffer
uniform sampler2D colortex10; // bloom tile

// Screen resolution
uniform float viewWidth;
uniform float viewHeight;
vec2 screenResolution = vec2(viewWidth, viewHeight);

// File includes
#include "/lib/post/bloom/tiles.glsl"

/* RENDERTARGETS: 0 */
layout (location = 0) out vec4 mainBuffer;

// This pass is responsible for averaging the bloom tiles and apply them to the main buffer

void main()
{
    vec3 color = vec3(0.0);

    // Take the average of all 7 tiles
    for (int i = 0; i < 7; i++)
    {
        color += sampleTile(fTexCoord, colortex10, i);
    }
    color /= 7.0;

    // And apply it by mixing, mix because it will be "energy conserving" unlike when you just add it on top
    color = mix(texture(colortex0, fTexCoord).rgb, color, 0.5);

    mainBuffer = vec4(color, 1.0);
}