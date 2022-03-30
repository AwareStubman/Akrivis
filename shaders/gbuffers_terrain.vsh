#version 330

in vec3 vaPosition;
in vec4 vaColor;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 chunkOffset;

out vec2 fTexCoord;
out vec2 flmCoord;
out vec4 fBiomeColor;

const mat4 TEXTURE_MATRIX_2 = mat4(vec4(0.00390625, 0.0, 0.0, 0.0), vec4(0.0, 0.00390625, 0.0, 0.0), vec4(0.0, 0.0, 0.00390625, 0.0), vec4(0.03125, 0.03125, 0.03125, 1.0));

void main()
{
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);

    fTexCoord = gl_MultiTexCoord0.xy;

    flmCoord = (TEXTURE_MATRIX_2 * gl_MultiTexCoord1).xy;

    fBiomeColor = vaColor;
}