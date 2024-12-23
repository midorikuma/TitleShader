title @s[tag=showkey] actionbar "Shift"
execute if entity @s[tag=postviewer] as @s at @s run spectate @e[distance=..0,tag=post,limit=1]
advancement revoke @s only ktos:detect/shift