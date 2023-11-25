#undef main

ivec3 textColorRGB = ivec3(vertexColor.rgb*255.0);
int textColorDigit = (textColorRGB.r<<16) + (textColorRGB.g<<8) + textColorRGB.b;

in float flag;
in vec2 fragCoord;

in vec3  iResolution;           // viewport resolution (in pixels)
in float iTime;                 // shader playback time (in seconds)
// in float iTimeDelta;            // render time (in seconds)
// in int   iFrame;                // shader playback frame
// in float iChannelTime[4];       // channel playback time (in seconds)
// in vec3  iChannelResolution[4]; // channel resolution (in pixels)
in vec4  iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
// in vec4  iDate;                 // (year, month, day, time in seconds)
// in float iSampleRate;           // sound sample rate (i.e., 44100)

// Add .glsl sources here
#define FILE test_rgb
#moj_import <test_rgb.glsl>
#define FILE test_hsv
#moj_import <test_hsv.glsl>
#define FILE test_digit
#moj_import <test_digit.glsl>
// #define FILE file_name
// #moj_import

void main() {
    switch(int(flag)){
        case -1: defaultmain();
        break;
        
        #moj_import <_cton.glsl>
        // Add cases here
        case 0: fragColor = vec4(vertexColor.rgb,1.0);
        break;
        case 1: test_rgb();
        break;
        case 2: test_hsv();
        break;
        case 3: test_digit();
        break;
        // case A: file_name();
        // break;
        
        default: discard;
    }
}