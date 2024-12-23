#version 330

uniform sampler2D MainSampler;
uniform sampler2D DataSampler;

uniform float GameTime;

in vec2 texCoord;

out vec4 fragColor;

bool flag(in sampler2D Sampler){
    return texelFetch(Sampler, ivec2(0), 0).rgb == vec3(12.,34.,56.)/255.0;
}

void main() {
    ivec2 Coord = ivec2(gl_FragCoord.xy);
    fragColor = texelFetch(DataSampler, Coord, 0);
    if(flag(MainSampler)) fragColor = texelFetch(MainSampler, Coord, 0);
    
}
