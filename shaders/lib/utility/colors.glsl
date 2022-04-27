float getLuminance(vec3 v) { return dot(v, vec3(0.2126, 0.7152, 0.0722)); }

// ACES Tonemapping
//taken from https://64.github.io/tonemapping/#aces
vec3 RTT_ODT_FIT(vec3 v)
{
    vec3 a = v * (v + 0.0245786) - 0.000090537;
    vec3 b = v * (0.983729 * v + 0.4329510) + 0.238081;
    return a / b;
}
vec3 ACES_fitted(vec3 v)
{
    const mat3 ACES_INPUT_MATRIX = mat3(
        0.59719, 0.35458, 0.04823,
        0.07600, 0.90834, 0.01566,
        0.02840, 0.13383, 0.83777
    );
    const mat3 ACES_OUTPUT_MATRIX = mat3(
        1.60475, -0.53108, -0.07367,
        -0.10208,  1.10813, -0.00605,
        -0.00327, -0.07276,  1.07602
    );
    
    v = v * ACES_INPUT_MATRIX;
    v = RTT_ODT_FIT(v);
    return v * ACES_OUTPUT_MATRIX;
}

vec3 adjustSaturation(vec3 v, float saturation) { return mix(vec3(getLuminance(v)), v, saturation); }
vec3 adjustContrast(vec3 v, float contrast) { return (v - 0.5) * contrast + 0.5; }