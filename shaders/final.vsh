#version 330

out vec2 fTexCoord;

void main()
{
    // we do it this way to keep support between Iris and Optifine
    gl_Position = gl_ProjectionMatrix * gl_Vertex; 
    fTexCoord = gl_Position.xy * 0.5 + 0.5;
}