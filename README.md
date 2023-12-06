[日本語](https://github.com/midorikuma/TitleShader/blob/main/README-ja.md) | English
# TitleShader
TitleShader is a ResourcePack Shader for Minecraft that allows you to display Shadertoy shaders using the title command.

# How to Use
## Setup
First, install the `TitleShaderRP` resource pack.

Then, apply two data packs: `TitleShaderDP` and `ScoreToColorDP` (available at [this link](https://github.com/midorikuma/DP_Libraries)).

After entering the world with these data packs, run the following setup commands:
```
/function stoc:setup
/scoreboard players set @s TextColorR 0
/scoreboard players set @s TextColorG 0
/scoreboard players set @s TextColorB 0
```


## Displaying Shaders
To display the shader, use the following command:
```
/function titleshader:rgb {id:0}
```
The `id` parameter should be a number between 0 and 127, with 0 set for debug shaders by default.

## Adding New Shaders
To add new shaders, place the GLSL shader files in the `TitleShaderRP\assets\minecraft\shaders\include` folder and then:
1. Edit `_fsh.glsl` in the same folder to link your shader's id.
2. Uncomment lines 22-24 and replace `"file_name"` on line 23 with your shader file name.
3. Add `<"file_name".glsl>` on line 24.
4. Uncomment lines 35 and 36 and repeat the `"file_name"` replacement.
5. The id value before `"file_name"` links the id to your shader.

Example command to link an id to a shader:
```
/function titleshader:rgb {id:1}
```

## Linking Scores and Shaders
When executing `titleshader:rgb`, the shader reads values from the `TextColorR`, `TextColorG`, and `TextColorB` scores of the player executing the command. These scores can range from 0-255 for each RGB component.

Additional Commands:
- `titleshader:hsv` for HSV color values from the `TextColorH`, `TextColorS`, and `TextColorV` scores (H:0-360, S:0-255, V:0-255).
- `titleshader:decimal` for Decimal color value from the `TextColorDecimal` scores (Decimal:0-16777215).

Shader scores are normalized to the range 0.0-1.0 and used in `vertexColor.rgb`.

When the `iMouse` and `iTime` variables commonly used in Shadertoy are called in the shader,

the values are reflected as follows:
- `vertexColor.xy` represents `iMouse`.
- `vertexColor.z` represents `iTime`.

To use `iTime` as seconds counted from command execution, use:
```
/function titleshader:time {id:0}
```
