#undef main

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

#define fsh
#define shader(case_number, func) case case_number: func(fragColor, fragCoord); break;

// Add .glsl sources here
#undef mainImage
#define mainImage debug
#moj_import <debug.glsl>
// #undef mainImage
// #define mainImage file_name
// #moj_import //<file_name.glsl>


void main() {
    switch(int(flag)){
        default: defaultmain();
        break;
        
        // Add shaders here
        shader(0, debug)
        // shader(1, file_name)
        
    }
}