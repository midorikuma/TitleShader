#ifndef fsh
const vec4 vertexColor = vec4(vec3(128,128,128)/255.0 ,1.0);
const vec4 mainColor = vec4(1.0, 0.0, 0.0, 1.0);
#endif

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
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

    fragColor.rgb = mix(mainColor.rgb, vec3((mainColor.r+mainColor.g+mainColor.b)/3.0), alpha);
    fragColor.a = 1.0;
}