// Generated with: https://drdesten.github.io/web/tools/gaussian_kernel/
const float gaussKernel_3[3] = float[](
   0.375,
   0.25,
   0.0625
);

vec3 fastGaussBlur(vec2 texcoord, int lod)
{
    vec3 result = vec3(0.0);
    float accum_w = 0.0;
    for (int x = -2; x <= 2; x++)
        for (int y = -2; y <= 2; y++)
        {
            float weight = gaussKernel_3[abs(x)] * gaussKernel_3[abs(y)];
            vec2 sampleCoord = texcoord + vec2(x, y) / screenResolution * float(1 << lod);

            //if (clamp(sampleCoord, 0.0, 1.0) != sampleCoord) continue;

            result += texture(colortex0, sampleCoord, 0.0).rgb * weight;
            accum_w += weight;
        }
    result /= accum_w;

    return result;
}