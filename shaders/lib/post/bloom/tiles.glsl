bool getCurrentTile(inout vec2 texcoord, int level)
{
    // False = not in tile
    // True = is in tile
    bool above0 = level > 0;
    float halfsubstract = above0 ? 0.5 : 0.0;
    
    float offset = 1.0 - 1.0 / float(1 << level);
    { // will need to do some special cases due to how the tile is laid out
        offset -= halfsubstract;

        // to avoid branching? because ternaries become a select when both sides are already evaluated
        float iftrue = float(level-1) * 0.01;
        float padding = above0 ? iftrue : 0.0;

        offset += padding;
    }
    float size = 1.0 / float(1 << (level+1));

    vec2 minBound = (floor((vec2(offset, above0 ? 0.51 : 0.0)) * screenResolution) + 0.5) / screenResolution;
    vec2 maxBound = (floor((minBound + size) * screenResolution) + 0.5) / screenResolution;

    bool isInTile = all(greaterThanEqual(texcoord, minBound)) && all(lessThanEqual(texcoord, maxBound));
    texcoord = (texcoord - minBound) / (maxBound - minBound);
    return isInTile;
}

vec2 getTileCoord(vec2 texcoord, int level)
{
    bool above0 = level > 0;
    float halfsubstract = above0 ? 0.5 : 0.0;
    
    float offset = 1.0 - 1.0 / float(1 << level);
    { // will need to do some special cases due to how the tile is laid out
        offset -= halfsubstract;

        // to avoid branching? because ternaries become a select when both sides are already evaluated
        float iftrue = float(level-1) * 0.01;
        float padding = above0 ? iftrue : 0.0;

        offset += padding;
    }
    float size = 1.0 / float(1 << (level+1));

    vec2 minBound = (floor((vec2(offset, above0 ? 0.51 : 0.0)) * screenResolution) + 0.5) / screenResolution;
    vec2 maxBound = (floor((minBound + size) * screenResolution) + 0.5) / screenResolution;

    // Convert the [0, 1] ranged texcoord to [offset, offset+size] range
    return mix(minBound, maxBound, texcoord);
}