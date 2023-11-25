const int dots[] = int[](
    0xfbdf, 0xf464, 0xf496, 0xf8ef, 0x4f51, 0xfc3f, 0xfd3f, 0x248f, 0x75ae, 0xfcbf,
    0x0, 0x9797, 0xed1e, 0xfb57, 0x99f9, 0x7c3e, 0x2255, 0x404, 0x4400
    );

ivec3 digit3 (in float d){
    int id = int(d);
    return ivec3(id/100,id%100/10,id%10);
}
int convert_character(vec2 texCoord, vec2 offset, ivec4 ns) {
    vec2 tpos = (texCoord-offset/8.0) * 8.0;
    tpos.y *= -1.0;
    float ts = 1.0;
    vec2 uvs = vec2(floor(tpos.x/1.0)*1.0,0.0);
    bool tf = all(bvec4(lessThan(uvs,tpos),lessThan(tpos,uvs+ts)));
    
    vec2 p = floor(vec2(fract((tpos + uvs) / ts) * 5.0));
    bool pd = p.x<4.0 && p.y<4.0;

    float j = p.y * 4.0 + p.x;
    int dn = int(tpos.x+1.0)-1;
    int n = 0<=dn&&dn<4 ? ns[dn] : 10;
    float nval = mod(float(dots[n]), exp2(j + 1.0));
    bool nf = floor(nval / exp2(j)) == 1.0;

    return int(tf && pd && nf);
}
#ifdef SHADER_TOY
    vec4 vertexColor = vec4(vec3(128,128,25)/255.0 ,1.0);
    ivec3 textColorRGB;
    int textColorDigit;
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    #StrictCompatibility
#elif defined FILE
    void FILE()
    #undef FILE
#endif
{
    vec2 nCoord;
    //座標正規化(0~1)
    nCoord = fragCoord/iResolution.xy;
    //座標オフセット
    nCoord -= vertexColor.rg;
    //座標正規化(max基準)
    nCoord *= iResolution.xy/max(iResolution.x,iResolution.y);

    vec3 color;
    //色設定(単色)
    // color = vec3(0.0,0.0,0.0);
    //色設定(座標)
    color = vertexColor.rgb;
    //色設定(円形)
    float alpha = float(vertexColor.b*sqrt(2.0)<length(nCoord));

    fragColor = vec4(color,alpha/1.0);
    
    
    int charFlag = 0;
    nCoord = (fragCoord * 2.0 - iResolution.xy)*2.0/iResolution.x+vec2(1.0,0.0);
    vec3 RGB = vertexColor.rgb;
    RGB *= vec3(255.);

    charFlag += convert_character(nCoord,vec2(0.5,0.0), ivec4(11,12,13,17));
    charFlag += convert_character(nCoord,vec2(4.5,0.0), ivec4(digit3(RGB.r),18));
    charFlag += convert_character(nCoord,vec2(8.5,0.0), ivec4(digit3(RGB.g),18));
    charFlag += convert_character(nCoord,vec2(12.5,0.0), ivec4(digit3(RGB.b),10));
    
    vec4 charcol = vec4(vec3(1.0), 1.0);
    fragColor = bool(charFlag) ? charcol : fragColor;
}