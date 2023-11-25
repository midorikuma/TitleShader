
#ifdef SHADER_TOY
const int dots[] = int[](0xfbdf, 0xf464, 0xf496, 0xf8ef, 0x4f51, 0xfc3f, 0xfd3f, 0x248f, 0x75ae, 0xfcbf, 0x0);
#endif

//Digit Calculation
int exdigit(int v, int d) {
    int dv=1;
    for(int i=0; i<d; ++i) dv*=10;
    dv /= 10;
    return (0<dv&&dv<=v)  ? v%(dv*10)/dv : 10;
}

int convert_character(vec2 texCoord, int n) {
    vec2 tpos = texCoord * 32.0;
    tpos.y *= -1.0;
    float ts = 4.0;
    vec2 uvs = vec2(floor(tpos.x/4.0)*4.0,0.0);
    bool tf = all(bvec4(lessThan(uvs,tpos),lessThan(tpos,uvs+ts)));
    
    vec2 p = floor(vec2(fract((tpos + uvs) / ts) * 5.0));
    bool pd = p.x<4.0 && p.y<4.0;

    float j = p.y * 4.0 + p.x;
    float nval = mod(float(dots[n]), exp2(j + 1.0));
    bool nf = floor(nval / exp2(j)) == 1.0;

    return int(tf && pd && nf);
}

#ifdef SHADER_TOY
    vec4 vertexColor;
    ivec3 textColorRGB;
    int textColorDigit = 1000;
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    #StrictCompatibility
#elif defined FILE
    void FILE()
    #undef FILE
#endif
{
    vec2 nCoord;
    //座標正規化(-1~1)
    nCoord = (fragCoord * 2.0 - iResolution.xy)/(max(iResolution.x,iResolution.y)*sqrt(2.0));

    float angle = (atan(nCoord.y,nCoord.x)/acos(-1.0)+1.0)/2.0;
    float split = 50.0;
    // float v = float(iTime*1000.0)/float(2<<24-1)*(split+1.0);
    float v = float(textColorDigit*1000)/float(2<<24-1)*(split+1.0);
    bool alpha = length(nCoord)*split<angle+floor(v-1.0);
    alpha = alpha|| length(nCoord)*split<angle+floor(v) && angle<fract(v);

    fragColor = alpha ? vec4(0.0) : vec4(vec3(0.0),1.0);
    
    vec4 charcol = vec4(vec3(1.0,0.0,0.0), 1.0);
    //int n = int(iTime);
    //0-16777215
    int n = textColorDigit;
    nCoord *= 2.0;
    nCoord.x += 0.5;
    int charflag = 0;
    charflag += convert_character(nCoord, exdigit(n, int(9.0-nCoord.x*8.0)));
    fragColor = bool(charflag) ? charcol : fragColor;
}