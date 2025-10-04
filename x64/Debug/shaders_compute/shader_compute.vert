#version 450

layout(location = 0) in vec4 inPosition;
layout(location = 1) in vec4 inColor;

layout(location = 0) out vec4 fragColor;
layout(location = 1) out float fragDepth;  // Add this

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
    float deltaTime;
} ubo;

void main() {
    vec4 worldPos = ubo.model * inPosition;
    vec4 viewPos = ubo.view * worldPos;
    vec4 clipPos = ubo.proj * viewPos;
    
    gl_Position = clipPos;
    fragDepth = clipPos.z / clipPos.w;  // Normalized device coordinates Z
    
    fragColor = vec4(inColor.rgb, 1.0f);
    //fragColor = vec4((gl_FragCoord.z).rrr, 1.0); // Depth debug
    gl_PointSize = clamp(10.0 / (1.0 + length(viewPos.xyz)), 2.0, 15.0);
}   