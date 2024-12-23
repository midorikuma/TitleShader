### 保存したcoreシェーダーidから実行
execute store result storage ktos:shaderidtmp id int 1 run scoreboard players get @s shaderidcore
execute if entity @s[tag=coreviewer] run function coreshader:rgb with storage ktos:shaderidtmp
### 保存したpostシェーダーidから実行
execute store result storage ktos:shaderidtmp id int 1 run scoreboard players get @s shaderidpost
execute if entity @s[tag=postviewer] run function postshader:rgb with storage ktos:shaderidtmp