### coreシェーダーを停止
title @s clear
tag @s remove coreviewer
### postシェーダーを停止
spectate @s @s
execute if entity @s[tag=presurvival] run gamemode survival
execute if entity @s[tag=precreative] run gamemode creative
execute if entity @s[tag=preadventure] run gamemode adventure
tag @s remove presurvival
tag @s remove precreative
tag @s remove preadventure
tag @e[distance=..0,tag=post] add postkill
execute as @e[distance=..0,tag=post] anchored eyes positioned ^ ^ ^ run tag @e[distance=..0.00001,tag=post_trigger] add postkill
tp @e[tag=postkill] ~ -1000 ~
kill @e[tag=postkill]
tag @s remove postviewer
### リロード
function ktos:load