#ifdef SHADER_TOY
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
#endif

const float PI2 = acos(-1.0)*2.0;
const float LenSq = 0.5;
const float inRad = (LenSq+0.05)*sqrt(2.0);
const float OutRad = 0.95;
const vec3 LenCurH = vec3(0.05,0.01,0.5);
const vec2 LenCurSV = vec2(0.06,0.03);

vec3 Normalize(in vec2 coord)
{
    vec2 nCoord = (coord * 2.0 - iResolution.xy)/min(iResolution.x,iResolution.y);
    float angle = fract(atan(nCoord.y,nCoord.x)/PI2+1.0);
    return vec3(nCoord,angle);
}
vec3 hsv2rgb(in vec3 HSV)
{
    return ((clamp(abs(fract(HSV.r+vec3(0,2,1)/3.)*6.-3.)-1.,0.,1.)-1.)*HSV.g+1.)*HSV.b;
}

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}


#ifdef SHADER_TOY
    vec4 vertexColor = vec4(vec3(128,64,64)/255. ,1.0);
    ivec3 textColorRGB;
    int textColorDigit;
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    #StrictCompatibility
#elif defined FILE
    void FILE()
    #undef FILE
#endif
{
    //HSV色空間表示設定
    float scale = 1.0;
    vec2 fragCoordScaled = fragCoord * scale;
    vec3 nCoords = Normalize(fragCoordScaled);
    vec3 nMouses;
    // vec3 nMouses = Normalize(iMouse.xy);
    // nMouses.xy += vec2(0.5);
    // vec3 nMousesClick = Normalize(abs(iMouse.zw));
    vec3 HSVtmp = rgb2hsv(vertexColor.rgb);
    nMouses.z = HSVtmp.r;
    nMouses.xy = HSVtmp.gb;
    
    float addrot = floor(mod(nMouses.z-0.25,1.0)*2.0)*0.5;
    float lenZ = abs(mod(nMouses.z+addrot,1.0)-mod(nCoords.z+addrot,1.0));
    float lenC = length(nCoords.xy);
    bool circle = inRad<lenC && lenC<OutRad;
    bool cursorH = lenZ<LenCurH.y/lenC && inRad-LenCurH.x<lenC && lenC<OutRad+LenCurH.x;
    bool cursorHin = lenZ<LenCurH.y/lenC*LenCurH.z && circle;
    cursorH = cursorH && !cursorHin;

    float lenXY = length((nMouses.xy-vec2(0.5))-nCoords.xy);
    bool square = abs(nCoords.x)<LenSq && abs(nCoords.y)<LenSq;
    bool cursorSV = lenXY < LenCurSV.x;
    bool cursorSVin = lenXY < LenCurSV.y;
    cursorSV = cursorSV && !cursorSVin;
    
    
    vec3 HSV = nMouses.zxy;
    vec3 inCol = hsv2rgb(vec3(HSV.r,nCoords.xy+0.5));
    vec3 outCol = hsv2rgb(vec3(nCoords.z,1.0,1.0));
    vec3 selectedCol = hsv2rgb(HSV);
    vec3 col = square ? inCol : outCol;
    
    bool alpha = !circle&&!cursorH && !square&&!cursorSV;
    bool inside = max(abs(nCoords.x),abs(nCoords.y))<1.0;
    col = alpha ? (inside ? vec3(0.5) : selectedCol) : col;
    
    col = cursorH||cursorSV ? vec3(1.0) : col;
    col = cursorHin ? hsv2rgb(vec3(HSV.r,1.0,1.0)) : col;
    col = cursorSVin ? selectedCol : col;

    vec2 texCoord = fragCoordScaled/iResolution.xy;
    fragColor = texCoord.x*scale<2.0&&texCoord.y*scale<2.0 ? vec4(col,1.0) : fragColor;



    //文字表示設定
    int charFlag = 0;
    vec2 nCoord = (fragCoordScaled * 2.0 - iResolution.xy)/min(iResolution.x,iResolution.y)+vec2(1.0,-1.0);
    vec3 RGB = vertexColor.rgb;
    HSV *= vec3(360.,255.,255.);
    RGB *= vec3(255.);

    charFlag += convert_character(nCoord,vec2(0.5,-0.5), ivec4(14,15,16,17));
    charFlag += convert_character(nCoord,vec2(4.5,-0.5), ivec4(digit3(HSV.r),18));
    charFlag += convert_character(nCoord,vec2(8.5,-0.5), ivec4(digit3(HSV.g),18));
    charFlag += convert_character(nCoord,vec2(12.5,-0.5), ivec4(digit3(HSV.b),10));

    charFlag += convert_character(nCoord,vec2(0.5,-1.5), ivec4(11,12,13,17));
    charFlag += convert_character(nCoord,vec2(4.5,-1.5), ivec4(digit3(RGB.r),18));
    charFlag += convert_character(nCoord,vec2(8.5,-1.5), ivec4(digit3(RGB.g),18));
    charFlag += convert_character(nCoord,vec2(12.5,-1.5), ivec4(digit3(RGB.b),10));
    
    vec4 charcol = vec4(vec3(0.0), 1.0);
    fragColor = bool(charFlag) ? charcol : fragColor;
}
