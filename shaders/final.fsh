#version 330

// Vertex shader inputs
in vec2 fTexCoord;

// Uniform buffers
uniform sampler2D colortex0;

void main()
{
    gl_FragColor = texture(colortex0, fTexCoord);
}