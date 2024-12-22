#undef main

flat out int flag;
flat out int type;
out vec2 fragCoord;
out vec4 vertexColor;

out vec3  iResolution;           // viewport resolution (in pixels)
out float iTime;                 // shader playback time (in seconds)
// out float iTimeDelta;            // render time (in seconds)
// out int   iFrame;                // shader playback frame
// out float iChannelTime[4];       // channel playback time (in seconds)
// out vec3  iChannelResolution[4]; // channel resolution (in pixels)
out vec4  iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
// out vec4  iDate;                 // (year, month, day, time in seconds)
// out float iSampleRate;           // sound sample rate (i.e., 44100)

uniform vec2 ScreenSize;
uniform float GameTime;

const ivec4 vposx = ivec4(-1, -1, 1, 1);
const ivec4 vposy = ivec4(1, -1, -1, 1);

#moj_import <post/main/_setting.glsl>
ivec3 getVal(in int x){
    return ivec3(texelFetch(DataSampler, ivec2(x-1,0), 0).rgb*255.0);
}

void main() {
    defaultmain();

    flag = -1;
    type = -1;
    if(getVal(1) == ivec3(12,34,56)){
        int glVID = gl_VertexID % 4;
        vec2 offset = vec2(vposx[glVID],vposy[glVID]);

        vertexColor = texelFetch(DataSampler, ivec2(2,0), 0);
        gl_Position = vec4(offset+Shift, Depth/Scale, 1.0/Scale);
        gl_Position.z = -1.0;
        // gl_Position *= float(mod(Position.z,1.0)!=0.0);

        ivec3 col2 = getVal(2);
        flag = col2.r;
        type = col2.g;
        fragCoord = (offset+1.0)/2.0*ScreenSize;

        iResolution = vec3(ScreenSize,0.0);
        ivec3 col4 = getVal(4);
        int tick = ((col4.r<<8)*200)+(col4.g*200)+col4.b;
        tick -= col2.b;
        iTime = float(tick)/200.;
        iMouse = vertexColor.xyxy*ScreenSize.xyxy;
    }
}