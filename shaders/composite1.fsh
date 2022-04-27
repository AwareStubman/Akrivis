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

/*
Enable mipmapping to prevent flickering when in motion
And generate bloom tiles
*/
/*
const bool colortex0MipmapEnabled = true;
*/

// We will now do 5 bloom tiles

void main()
{
    vec3 color = vec3(0.0);

    // Run a for loop that checks what mip level a pixel is in
    //runs 5 times because we're doing 5 bloom tiles
    for (int i = 0; i < 5; i++)
    {
        vec2 newCoord = fTexCoord;
        bool isInTile = getCurrentTile(newCoord, i);

        if (isInTile)
        {
            // Do a 5x5 gaussian blur
            color += fastGaussBlur(newCoord, i+1);
            break;
        }
    }

    bloomTile = color;
}