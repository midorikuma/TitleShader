[日本語](https://github.com/midorikuma/TitleShader/blob/main/README-ja.md) | English
# TitleShader
A ResourcePack Shader that can call and display shaders from the title command.

Use the title command on the Minecraft to display the shaders for Shadertoy written in the glsl file.

# Setup
Apply the following resource pack

* TitleShaderRP

Apply the following two data packs

* TitleShaderDP
* ScoreToColorDP
＞[https://github.com/midorikuma/DP_Libraries]

Enter the world to which the data pack has been applied and execute the following command.
```
/function stoc:setup
/scoreboard players set @s TextColorR 0
/scoreboard players set @s TextColorG 0
/scoreboard players set @s TextColorB 0
```

# Execution
The following commands can be used to display shaders to the player
```
/function titleshader:rgb {id:0}
```
id can be a number between 0 and 127. 0 is set to debug shaders by default.

# Add shaders
To add the new shaders, put the glsl file describing the shaders into the TitleShaderRP\assets\minecraft\shaders\include folder

Next, from _fsh.glsl in the same include folder, link the id of the command to the shader you have added.
***
Once you open the file,

Uncomment lines 22-24,

Change "file_name" in line 23 to the name of the glsl file,

Add <"file_name".glsl> on line 24.
***
Finally,

Uncomment lines 35 and 36,

Change "file_name" to the name of the glsl file as before

where the value written just before "file_name" is the value of the id
```
/function titleshader:rgb {id:1}
```
You have now tied the id to the shader you added.

# Linking Scores and Shaders
When the titleshader:rgb function is executed,

the score TextColorR, TextColorG and TextColorB values are read by the shader

(The score that the player executing the command has is reflected)

Scores can be set in the range of 0-255 for each RGB.
***
In addition, by executing titleshader:hsv,

colors can be set in HSV from TextColorH, TextColorS, and TextColorV values (H:0-360, S:0-255, V:0-255)

In addition, by executing titleshader:digit,

colors can be set in decimal number from TextColorDigit  value (Digit:0-16777215).
***
On the shader side, the score is read as a color and the value is reflected in vertexColor.rgb in the normalized range 0.0-1.0

Also, when the iMouse and iTime variables commonly used in Shadertoy are called in the shader,

the values are reflected as follows

* vertexColor.xy -> iMouse
* vertexColor.z -> iTime

When using the titleshader:time function,

iTime can be used as "seconds counted as 0.0 when the command is executed".
```
/function titleshader:time {id:0}
```
