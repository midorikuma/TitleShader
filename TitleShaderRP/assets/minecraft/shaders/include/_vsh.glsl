#undef main

const ivec4 vposx = ivec4(-1, -1, 1, 1);
const ivec4 vposy = ivec4(1, -1, -1, 1);

uniform sampler2D Sampler0;
uniform vec2 ScreenSize;
uniform float GameTime;

out float flag;
out vec2 fragCoord;

out vec3  iResolution;           // viewport resolution (in pixels)
out float iTime;                 // shader playback time (in seconds)
// out float iTimeDelta;            // render time (in seconds)
// out int   iFrame;                // shader playback frame
// out float iChannelTime[4];       // channel playback time (in seconds)
// out vec3  iChannelResolution[4]; // channel resolution (in pixels)
out vec4  iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
// out vec4  iDate;                 // (year, month, day, time in seconds)
// out float iSampleRate;           // sound sample rate (i.e., 44100)

// Setting of shader display
const vec2 Shift = vec2(0.0,0.0);
const float Depth = -1.0;
const float Scale = 1.0;

void main() {
    defaultmain();

    flag = -2.0;
    ivec2 iCoord = ivec2(texCoord0 * textureSize(Sampler0,0));
    iCoord.y -= int(1<(gl_VertexID+1) % 4);
    if(texelFetch(Sampler0, iCoord, 0)==vec4(12,34,56,78)/255.0){
        int glVID = gl_VertexID % 4;
        vec2 offset = vec2(vposx[glVID],vposy[glVID]);

        vertexColor = Color;
        gl_Position = vec4(offset+Shift, Depth/Scale, 1.0/Scale);
        gl_Position *= float(Position.z!=0.0);

        iCoord.y += 1;
        flag = texelFetch(Sampler0, iCoord, 0).r*255.0;
        fragCoord = (offset+1.0)/2.0*ScreenSize;

        iResolution = vec3(ScreenSize,0.0);
        iTime = GameTime*24000.0/20.0;
    }
}