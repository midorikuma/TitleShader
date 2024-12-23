#undef main

flat in int flag;
flat in int type;
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
#moj_import <core/debug.glsl>
// #undef mainImage
// #define mainImage file_name
// #moj_import //<core/file_name.glsl>


void main() {
    // CORE
    if(type==0){
        switch(flag){
            default: defaultmain();
            break;
            
            // Add shaders here
            shader(0, debug)
            // shader(n, file_name)
        }

    // POST
    }else if(type==255){
        ivec2 pos = ivec2(ceil(gl_FragCoord.xy));
        if(pos.y==1) {
            switch(pos.x){
                case 1: fragColor.rgb=vec3(12.,34.,56.)/255.0;
                break;
                case 2: fragColor.rgb=vec3(flag,vertexColor.a,0.)/255.0;
                break;
                case 3: fragColor.rgb = vertexColor.rgb;
                break;
                case 4: fragColor.rgb = vec3(0.0);
                break;
                default: discard;
                break;
            }
            fragColor.a = 1.0;
        }else{
            discard;
        }

    // DEFAULT
    }else{
        defaultmain();
    }
}