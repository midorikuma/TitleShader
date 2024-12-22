#ifndef fsh
const vec4 vertexColor = vec4(vec3(0,128,0)/255.0 ,1.0);
#endif

const int dots[] = int[](0x0, 0xf000, 0x4224, 0x2442, 0xa4a, 0x4e40, 0x4400, 0xe00, 0x400, 0x1248, 0xfbdf, 0xf464, 0xf496, 0xf8ef, 0x4f51, 0xfc3f, 0xfd3f, 0x248f, 0x75ae, 0xfcbf, 0x404, 0x4404, 0x424, 0xf0f, 0x242, 0x4496, 0xedb6, 0x9f96, 0xfb57, 0xe11e, 0x7997, 0xf17f, 0x171f, 0xed1e, 0x99f9, 0x7227, 0x254f, 0x9535, 0x7111, 0x99df, 0x9db9, 0x6996, 0x1797, 0xed96, 0x9797, 0x7c3e, 0x222f, 0x6999, 0x2255, 0xfd99, 0x9669, 0x22f9, 0xf24f);

ivec4 digit4 (in int d){
    return ivec4(d%10000/1000,d%1000/100,d%100/10,d%10)+10;
}
int convert_character(vec2 texCoord, vec2 offset, ivec4 ns) {
    vec2 tpos = (texCoord - offset / 8.0) * 8.0;
    tpos.y *= -1.0;
    vec2 uvs = vec2(floor(tpos.x) * 1.0, 0.0);

    bool isWithinBounds = all(bvec4(lessThan(uvs, tpos), lessThan(tpos, uvs + 1.0)));
    if (!isWithinBounds) return 0;

    vec2 p = floor(vec2(fract((tpos + uvs) / 1.0) * 5.0));
    bool isDotPosition = p.x < 4.0 && p.y < 4.0;
    if (!isDotPosition) return 0;

    float j = p.y * 4.0 + p.x;
    int dn = int(uvs.x);
    int dotIndex = 0 <= dn && dn < 4 ? ns[dn] : 0;
    float dotValue = mod(float(dots[dotIndex]), exp2(j + 1.0));
    bool isDotFilled = floor(dotValue / exp2(j)) == 1.0;
    return int(isDotFilled);
}


void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    ivec3 textColorRGB = ivec3(vertexColor.rgb*255.0);
    int textColorDecimal = (textColorRGB.r<<16) + (textColorRGB.g<<8) + textColorRGB.b;

    //座標正規化(0~1)
    vec2 nCoordp = (fragCoord-iMouse.xy)/max(iResolution.x,iResolution.y);
    //色設定
    fragColor = vec4(vertexColor.rgb,0.5);
    fragColor = length(nCoordp)<0.01 ? vec4(vec3(0.0),1.0) : fragColor;
    fragColor = length(nCoordp)<0.002 ? vec4(vec3(0.5),1.0) : fragColor;
    
    
    //文字表示設定
    int charFlag = 0;
    vec2 nCoord = (fragCoord * 2.0 - iResolution.xy)*2.0/iResolution.x+vec2(1.0,0.0);

    //RGB
    charFlag += convert_character(nCoord,vec2(0.5,0.0), ivec4(44,33,28,20));
    charFlag += convert_character(nCoord,vec2(4.5,0.0), ivec4(0,digit4(textColorRGB.r).yzw));
    charFlag += convert_character(nCoord,vec2(8.5,0.0), ivec4(6,digit4(textColorRGB.g).yzw));
    charFlag += convert_character(nCoord,vec2(12.5,0.0), ivec4(6,digit4(textColorRGB.b).yzw));
    //Decimal
    charFlag += convert_character(nCoord,vec2(0.5,-1.0), ivec4(30,31,29,35));
    charFlag += convert_character(nCoord,vec2(4.5,-1.0), ivec4(39,27,38,20));
    charFlag += convert_character(nCoord,vec2(8.5,-1.0), digit4(textColorDecimal/10000));
    charFlag += convert_character(nCoord,vec2(12.5,-1.0), digit4(textColorDecimal%10000));
    //Time
    charFlag += convert_character(nCoord,vec2(0.5,-2.0), ivec4(46,35,39,31));
    charFlag += convert_character(nCoord,vec2(4.5,-2.0), ivec4(20,0,0,0));
    charFlag += convert_character(nCoord,vec2(8.5,-2.0), ivec4(0,digit4(int(iTime)).yzw));
    charFlag += convert_character(nCoord,vec2(12.5,-2.0), ivec4(8,digit4(int(iTime*1000.0)).yzw));

    vec4 charcol = vec4(vec3(1.0), 1.0);
    fragColor = bool(charFlag) ? charcol : fragColor;
}