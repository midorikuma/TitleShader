# charsリストを生成する
chars_list = []
for i in range(0x000, 0x80, 0x10):
    line = "".join(["\\uE{:03X}".format(i + j) for j in range(0x10)])
    chars_list.append(line)

# JSONデータをテンプレート文字列で構築する
json_template = """
{{
    "providers": [
        {{
            "type": "bitmap",
            "file": "shaderfont:character.png",
            "height": 0,
            "ascent": 0,
            "chars": [
                {chars}
            ]
        }}
    ]
}}
"""

# charsリストを整形してテンプレートに挿入
formatted_chars = ",\n                ".join(f'"{char}"' for char in chars_list)
json_string = json_template.format(chars=formatted_chars)

# JSONデータをファイルに保存する
file_path = "overlay.json"
with open(file_path, "w", encoding="utf-8") as file:
    file.write(json_string)
