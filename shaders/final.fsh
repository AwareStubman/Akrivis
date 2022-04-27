#version 330

// Vertex shader inputs
in vec2 fTexCoord;

// Uniform buffer samplers
uniform sampler2D colortex0;

// Optifine provided noisetex
const int noiseTextureResolution = 128;
uniform sampler2D noisetex;

// File includes
#include "/lib/utility/colors.glsl"

void main()
{
    vec3 color = texture(colortex0, fTexCoord).rgb;
    color += texture(noisetex, gl_FragCoord.xy/float(noiseTextureResolution)).rgb / 256.0;

    color = adjustSaturation(color, 1.3);
    color = adjustContrast(color, 0.95); // decrease contrast since the aces tonemap increases contrast

    color = ACES_fitted(color); // apply tonemap

    color = pow(color, vec3(1.0/2.2)); // linear to sRGB

    color = clamp(color, 0.0, 1.0);

    gl_FragColor = vec4(color, 1.0);
}