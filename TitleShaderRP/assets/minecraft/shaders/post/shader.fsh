#version 330

uniform sampler2D MainSampler;
uniform sampler2D DataSampler;

in vec2 texCoord;

out vec4 fragColor;
vec4 mainColor;

#define main defaultmain
void main() {
    fragColor = texelFetch(MainSampler, ivec2(gl_FragCoord.xy), 0);
    mainColor = fragColor;
}
#moj_import <post/main/fsh.glsl>