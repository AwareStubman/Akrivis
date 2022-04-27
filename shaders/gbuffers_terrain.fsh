#version 330

// Vertex shader inputs
in vec2 fTexCoord;
in vec2 flmCoord;
in vec4 fBiomeColor;

// Uniform samplers
uniform sampler2D tex;
uniform sampler2D lightmap;
uniform sampler2D specular;

/* RENDERTARGETS: 0 */
layout (location = 0) out vec4 mainBuffer;

void main()
{
    vec4 color = vec4(0.0);
    vec4 albedo = texture(tex, fTexCoord);
    if (albedo.a <= 1.0/255.0) discard;
    
    // sRGB to linear
    albedo = pow(albedo, vec4(2.2));
    color = albedo * pow(texture(lightmap, flmCoord), vec4(2.2)) * pow(fBiomeColor, vec4(2.2));

    // add emissive
    float emission = texture(specular, fTexCoord).a;
    color.rgb += emission <= 0.99607843 ? emission / 0.99607843 * 30.0 * albedo.rgb : vec3(0.0);

    mainBuffer = color;
}