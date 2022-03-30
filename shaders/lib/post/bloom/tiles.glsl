bool getCurrentTile(inout vec2 texcoord, int level)
{
    // False = not in tile
    // True = is in tile
    float offset_x = 1.0 - 1.0 / float(1 << level);
    float upscale = float(1 << (level+1));
    float downscale = 1.0 / upscale;

    texcoord = (texcoord - vec2(offset_x, 0.0)) * upscale;
    return (fTexCoord.x >= offset_x && fTexCoord.x < offset_x + downscale && fTexCoord.y < downscale);
}

vec3 sampleTile(vec2 texcoord, sampler2D tileBuffer, int level)
{
    float offset_x = 1.0 - 1.0 / float(1 << level);
    float size = 1.0 / float(1 << (level+1));

    // Convert the [0, 1] range of texcoord to [offset_x, offset_x+size] range
    vec2 sampleCoord = mix(vec2(offset_x, 0.0), vec2(offset_x + size, size), texcoord);

    return texture(tileBuffer, sampleCoord).rgb;
}