## 定数設定
scoreboard players set ###240 TextColor 240

scoreboard players operation @s TextColor = @s TextColorB
execute store result score @s TextColorB run time query gametime
scoreboard players operation @s TextColorB %= ###240 TextColor

## 実行
data modify storage minecraft:stoc type set value "rgb"
$function postshader:run/run1 {id:$(id)}

scoreboard players operation @s TextColorB = @s TextColor