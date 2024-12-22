$summon text_display ~ ~ ~ {see_through:false,view_range:0.00001f,alignment:"center",Tags:["post_trigger"],text:'{"font":"shaderfont:postfont","text":"\\uE0$(id0)$(id1)","color":"$(color)"}'}
schedule clear postshader:run/run4
schedule function postshader:run/run4 1t