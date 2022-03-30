bool getCurrentTile(inout vec2 texcoord, int level)
{
    // False = not in tile
    // True = is in tile
    float offset = 1.0 - 1.0 / float(1 << level);
    float size = 1.0 / float(1 << (level+1));

    vec2 minBound = vec2(offset);
    vec2 maxBound = vec2(offset + size);

    bool isInTile = all(greaterThanEqual(texcoord, minBound)) && all(lessThanEqual(texcoord, maxBound));
    texcoord = clamp((texcoord - minBound) / (maxBound - minBound), 0.0, 1.0);
    return isInTile;
}

vec3 sampleTile(vec2 texcoord, sampler2D tileBuffer, int level)
{
    float offset = 1.0 - 1.0 / float(1 << level);
    float size = 1.0 / float(1 << (level+1));

    vec2 minBound = vec2(offset);
    vec2 maxBound = vec2(offset + size);

    // Convert the [0, 1] ranged texcoord to [offset, offset+size] range
    vec2 sampleCoord = mix(minBound, maxBound, texcoord);

    return texture(tileBuffer, sampleCoord).rgb;
}