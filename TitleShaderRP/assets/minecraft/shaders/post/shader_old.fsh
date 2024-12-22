#version 330

uniform sampler2D MainSampler;
uniform sampler2D DataSampler;

uniform float GameTime;
uniform vec2 ScreenSize;

in vec2 texCoord;

out vec4 fragColor;

bool flag(in sampler2D Sampler){
    return texelFetch(Sampler, ivec2(0), 0).rgb == vec3(12.,34.,56.)/255.0;
}

void main() {
    if(!flag(DataSampler)) fragColor = texelFetch(MainSampler, ivec2(gl_FragCoord.xy), 0);

    if(flag(MainSampler)) {
        vec3 vertexColor = texelFetch(MainSampler, ivec2(2,0), 0).rgb;
        vec2 iMouse = vertexColor.xy*ScreenSize;
        vec2 iResolution = ScreenSize;
        vec2 fragCoord = texCoord*ScreenSize;

        vec2 nCoord;
        //座標正規化(0~1)
        // nCoord = fragCoord/iResolution.xy;

        //座標正規化(-1~1)
        nCoord = (fragCoord-iMouse.xy) * 2.0;
        // nCoord /= iResolution.xy;
        nCoord /= min( iResolution.x, iResolution.y );

        vec3 color;
        //色設定(単色)
        color = vec3( 0.0, 0.0, 0.0 );
        //色設定(座標)
        // color.r = nCoord.x;
        // color.g = nCoord.y;

        //色設定(円形)
        // color = vec3( length(nCoord) );
        float alpha = float( vertexColor.b < length(nCoord) );

        fragColor.rgb = mix(fragColor.rgb, vec3((fragColor.r+fragColor.g+fragColor.b)/3.0), alpha);
    }
}