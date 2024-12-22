#undef main

flat out int flag;
flat out int type;
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

uniform sampler2D Sampler0;
uniform vec2 ScreenSize;
uniform float GameTime;

const ivec4 vposx = ivec4(-1, -1, 1, 1);
const ivec4 vposy = ivec4(1, -1, -1, 1);

#moj_import <core/main/_setting.glsl>

void main() {
    defaultmain();

    flag = -1;
    type = -1;
    ivec2 iCoord = ivec2(texCoord0 * textureSize(Sampler0,0));
    iCoord.y -= int(1<(gl_VertexID+1) % 4);
    if(texelFetch(Sampler0, iCoord, 0)==vec4(12,34,56,78)/255.0){
        int glVID = gl_VertexID % 4;
        vec2 offset = vec2(vposx[glVID],vposy[glVID]);

        vertexColor = Color;
        gl_Position = vec4(offset+Shift, Depth/Scale, 1.0/Scale);
        gl_Position.z = -1.0;
        gl_Position *= float(mod(Position.z,1.0)!=0.0);

        iCoord.y += 1;
        ivec4 texcol = ivec4(texelFetch(Sampler0, iCoord, 0)*255.1);
        flag = texcol.r;
        type = texcol.g;
        fragCoord = (offset+1.0)/2.0*ScreenSize;

        iResolution = vec3(ScreenSize,0.0);
        iTime = mod(GameTime*24000.0,240.0)-vertexColor.z*255.0;
        iTime += float(iTime<-1.0)*240.0;
        iTime = clamp(iTime/20.0,0.0,12.0);
        iMouse = vertexColor.xyxy*ScreenSize.xyxy;
    }
}