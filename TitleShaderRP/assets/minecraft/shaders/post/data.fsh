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
    fragColor.rgb = vec3(0.0);
    ivec2 Coord = ivec2(gl_FragCoord.xy);
    ivec2 pos = ivec2(ceil(gl_FragCoord.xy));
    int time1sec = int(GameTime*24000.0/20.0*200.0)%200;

    if(flag(DataSampler)){
        fragColor = texelFetch(DataSampler, Coord, 0);
        if(pos.y==1) {
            switch(pos.x){
                case 4:
                ivec4 i4Color = ivec4(fragColor*255.0);
                int t = (i4Color.r<<8)|i4Color.g;
                t += clamp(sign(i4Color.b-time1sec),0,1);
                fragColor.rgb = vec3((t>>8)&0xFF, t&0xFF, time1sec)/255.0;
                break;
            }
        }
    }
    
    if(flag(MainSampler)) {
        fragColor = texelFetch(MainSampler, Coord, 0);
        if(pos.y==1) {
            switch(pos.x){
                case 2:
                fragColor.b = float(time1sec)/255.0;
                break;
            }
        }
    }

    fragColor.a = 1.0;
}
