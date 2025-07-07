#version 450

layout(location = 0) in vec3 fragColor;
layout(location = 1) in float fragDepth;  // Add this

layout(location = 0) out vec4 outColor;

void main() {
    // Visualize depth as blue channel
    float z = (fragDepth + 1.0) * 0.5; // Map from [-1,1] to [0,1]
    outColor = vec4(fragColor.r, fragColor.g, z, 1.0);
    
    // Circular points
    vec2 circCoord = 2.0 * gl_PointCoord - 1.0;
    if (dot(circCoord, circCoord) > 1.0) {
        discard;
    }
}