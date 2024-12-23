tag @s add prepostviewer

### ゲームモード保存
tag @s[gamemode=survival] add presurvival
tag @s[gamemode=creative] add precreative
tag @s[gamemode=adventure] add preadventure
gamemode spectator @s
### postシェーダー用エンティティ生成
function ktos:startpost1 with entity @s
spectate @e[distance=..0,tag=post,limit=1]

$scoreboard players set @s shaderidpost $(id)
function ktos:display
schedule clear ktos:startpost2
schedule function ktos:startpost2 8t