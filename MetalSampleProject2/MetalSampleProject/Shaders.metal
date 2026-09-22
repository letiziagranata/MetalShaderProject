#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;


[[ stitchable ]] half4 basicColor(float2 position, half4 currentColor) {
    return half4(0.2, 0.6, 0.9, 1.0);
}

[[ stitchable ]] half4 gradient(float2 position, half4 currentColor) {
    float normalizedX = position.x / 300.0;
    float normalizedY = position.y / 300.0;
    
    half r = half(normalizedX);
    half g = half(normalizedY);
    half b = half(1.0 - normalizedX);
    
    return half4(r, g, b, 1.0);
}

[[ stitchable ]] half4 checkboard(float2 position, half4 currentColor, float tileSize, half4 fillColor) {
    uint2 gridCoords = uint2(position.x / tileSize, position.y / tileSize);
    
    bool shouldFill = (gridCoords.x ^ gridCoords.y) & 1;
    
    return shouldFill ? fillColor * currentColor.a : half4(0.0, 0.0, 0.0, 0.0);
}

[[ stitchable ]] half4 animatedColor(float2 position, half4 currentColor, float time) {
    half r = half((sin(time) + 1.0) * 0.5);
    
    half g = half((sin(time + 2.0) + 1.0) * 0.5);
    
    half b = half((sin(time + 4.0) + 1.0) * 0.5);

    return half4(r, g, b, 1.0);
}

[[ stitchable ]] half4 waveDistortion(float2 position, SwiftUI::Layer layer, float time) {
    float wave = sin(position.y * 0.05 + time * 2.0) * 15.0;
    
    float2 distortedPosition = position;
    distortedPosition.x += wave;
    
    return layer.sample(distortedPosition);
}

[[ stitchable ]] half4 waves(float2 position, half4 currentColor, float time, float intensity, float frequency) {
    float x = position.x / 300.0;
    float y = position.y / 300.0;
    float wave1 = sin(x * frequency + time * 2.0);
    float wave2 = sin(y * frequency + time * 1.5);
    float wave3 = sin((x + y) * frequency * 0.5 + time);
    float combined = (wave1 + wave2 + wave3) / 3.0;
    
    combined = combined * intensity;
    
    half value = half((combined + 1.0) * 0.5);
    
    half r = value;
    half g = half(1.0) - value;
    half b = half((sin(time) + 1.0) * 0.5);
    
    return half4(r, g, b, 1.0);
}

[[ stitchable ]] half4 pixelate(float2 position, SwiftUI::Layer layer, float pixelSize) {
    float2 pixelPosition = floor(position / pixelSize) * pixelSize;
    pixelPosition += pixelSize * 0.5;
    
    return layer.sample(pixelPosition);
}

[[ stitchable ]] half4 circles(float2 position, float time) {
    float2 center = float2(150.0, 150.0);
    float dist = distance(position, center);
    float circle = sin(dist * 0.1 - time * 2.0);
    half value = half((circle + 1.0) * 0.5);
    
    return half4(value, value * 0.5, 1.0 - value, 1.0);
}


[[ stitchable ]] half4 radialGradient(float2 position) {
    float2 center = float2(150.0, 150.0);
    float dist = distance(position, center);
    float normalizedDist = dist / 212.0;
    normalizedDist = clamp(normalizedDist, 0.0, 1.0);
    
    half r = half(1.0 - normalizedDist);
    half g = half(normalizedDist * 0.5);
    half b = half(normalizedDist);
    
    return half4(r, g, b, 1.0);
}

[[ stitchable ]] half4 plasma(float2 position, half4 currentColor, float time) {
    float x = position.x / 300.0;
    float y = position.y / 300.0;
    float wave1 = sin((x * 10.0) + time);
    float wave2 = sin((y * 10.0) + time * 1.3);
    float wave3 = sin((x + y) * 5.0 + time * 0.7);
    float wave4 = sin(sqrt(x * x + y * y) * 8.0 - time * 2.0);
    float combined = (wave1 + wave2 + wave3 + wave4) / 4.0;
    float value = (combined + 1.0) * 0.5;
    
    half r = half((sin(value * 6.28 + time) + 1.0) * 0.5);
    
    half g = half((sin(value * 6.28 + time + 2.09) + 1.0) * 0.5);
    
    half b = half((sin(value * 6.28 + time + 4.18) + 1.0) * 0.5);
    
    return half4(r, g, b, 1.0);
}

[[ stitchable ]] half4 kaleidoscope(float2 position, half4 currentColor, float time, float segments) {
    float2 center = float2(150.0, 150.0);
    
    float2 relPos = position - center;
    
    float angle = atan2(relPos.y, relPos.x);
    float dist = length(relPos);
    float segmentAngle = 6.28318 / segments;
    float normalizedAngle = angle / segmentAngle;
    float mirroredAngle = (floor(normalizedAngle) + 0.5) * segmentAngle;
    mirroredAngle += time * 0.5;
    float2 mirroredPos = center + float2(cos(mirroredAngle), sin(mirroredAngle)) * dist;
    float x = mirroredPos.x / 300.0;
    float y = mirroredPos.y / 300.0;
    float pattern = sin(x * 15.0) * sin(y * 15.0) * sin(dist * 0.1 - time * 2.0);
    
    pattern = (pattern + 1.0) * 0.5;
    
    half r = half(pattern);
    
    half g = half((sin(time + dist * 0.1) + 1.0) * 0.5);
    
    half b = half((cos(time + dist * 0.1) + 1.0) * 0.5);
    
    return half4(r, g, b, 1.0);
}


[[ stitchable ]] half4 tunnel(float2 position, half4 currentColor, float time) {
    float2 center = float2(150.0, 150.0);
    
    float2 relPos = position - center;
    
    float angle = atan2(relPos.y, relPos.x);
    float dist = length(relPos);
    float normalizedDist = dist / 212.0;
    float depth = 1.0 - normalizedDist;
    float rings = sin(depth * 20.0 - time * 3.0) * 0.5 + 0.5;
    float spokes = sin(angle * 8.0 + time * 2.0) * 0.5 + 0.5;
    float pattern = rings * spokes;
    float noise = sin(angle * 12.0 + time) * sin(depth * 15.0 + time * 1.5);
    noise = (noise + 1.0) * 0.5;
    
    half r = half(pattern * (1.0 - normalizedDist * 0.5));
    
    half g = half(noise * normalizedDist);

    half b = half((sin(angle + time) + 1.0) * 0.5 * depth);
    
    return half4(r, g, b, 1.0);
}


