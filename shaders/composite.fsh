#version 330

// Vertex shader inputs
in vec2 fTexCoord;

// Uniform buffer samplers
uniform sampler2D colortex0;

// Screen resolution
uniform float viewWidth;
uniform float viewHeight;
vec2 screenResolution = vec2(viewWidth, viewHeight);

// File includes
#include "/lib/constants/preprocessor.glsl"
#include "/lib/post/bloom/fastBlur.glsl"
#include "/lib/post/bloom/tiles.glsl"

/* RENDERTARGETS: 10 */
layout (location = 0) out vec3 bloomTile;

// In order to generate bloom tiles while trying to stay as fast as possible
//we need to use mipmapping, and to use them, we have to enable mipmapping for colortex0
// Also store bloom tiles as an R11F_G11F_B10F, the banding that comes after it should be not too much
// Also, since we're here, let's just set the colortex0's format to RGBA16F since we're going to work in HDR
/*
const bool colortex0MipmapEnabled = true;
const int colortex0Format = RGBA16F;
const int colortex10Format = R11F_G11F_B10F;
*/

// We will now do 7 bloom tiles, each with different blurriness following the pattern of:

void main()
{
    vec3 color = vec3(0.0);

    // Run a for loop that checks what mip level a pixel is in
    //runs 7 times because we're doing 7 bloom tiles
    for (int i = 0; i < 7; i++)
    {
        vec2 newCoord = fTexCoord;
        bool isInTile = getCurrentTile(newCoord, i);

        if (isInTile)
        {
            color += fastGaussBlur(newCoord, int(dot(screenResolution, vec2(0.5*0.01)) + 0.5));
            break;
        }
    }

    bloomTile = color;
}