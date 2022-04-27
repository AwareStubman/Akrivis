#version 330

out vec2 fTexCoord;

void main()
{
    gl_Position = gl_ProjectionMatrix * gl_Vertex; 
    fTexCoord = gl_Position.xy * 0.5 + 0.5;
}