#タイプ
type="core"

from PIL import Image

t = (12, 34, 56, 78)
typecol = 0

u = 255
out = Image.new("RGBA", (16, 16), (u, u, u, u))

for i in range(128):
    x = i % 16
    y = i // 16 * 2
    out.putpixel((x, y), t)
    out.putpixel((x, y + 1), (i, typecol, u, u))

out.save(type+"char.png")
