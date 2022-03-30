#version 330

// Vertex shader inputs
in vec2 fTexCoord;

// Uniform buffer samplers
uniform sampler2D colortex0;

void main()
{
    vec3 color = texture(colortex0, fTexCoord).rgb;
    //color = 1.0 - exp(-color * 1.0);
    color = pow(color, vec3(1.0/2.2));

    gl_FragColor = vec4(color, 1.0);
}