日本語 | [English](https://github.com/midorikuma/TitleShader/blob/main/README.md)
# TitleShader
titleコマンドからシェーダーを呼び出し、表示を行えるリソパシェーダーです

Shadertoy向けglslファイルに書かれたシェーダーを、マイクラ上でtitleコマンドを用いて表示できます。

# 準備
以下の1つのリソースパックを適用します

* TitleShaderRP

以下の2つのデータパックを導入します

* TitleShaderDP
* ScoreToColorDP
＞[https://github.com/midorikuma/DP_Libraries]

DPを入れたワールドに入り、以下のコマンドを実行します
```
/function stoc:setup
/scoreboard players set @s TextColorR 0
/scoreboard players set @s TextColorG 0
/scoreboard players set @s TextColorB 0
```

# 実行
以下のコマンドから、実行者に向けてシェーダーの表示を行えます
```
/function titleshader:rgb {id:0}
```
idには0～127の数値が入れられます、0にはデフォルトでデバッグ用シェーダーが設定されています

# シェーダーの追加
新しく表示されるシェーダーを追加するには、シェーダーが記述されたglslファイルをTitleShaderRP\assets\minecraft\shaders\includeフォルダに入れます

次に同じincludeフォルダ内にある_fsh.glslから、コマンドを実行する際のidと追加したシェーダーとの紐付けを行います
***
ファイルを開いたら

23-25行目のコメントアウトを解除し、

24行目の"file_name"をglslファイル名に変更、

25行目に<"file_name".glsl>を追加します
***
最後に

35行目のコメントアウトを解除し、

先程と同じように"file_name"をglslファイル名に変更します

ここで"file_name"の直前に記述した値がidの値となります
```
/function titleshader:rgb {id:1}
```
これでidと追加したシェーダーの紐付けが完了しました

# スコアとの連携
titleshader:rgbファンクションを実行時には

スコアTextColorR, TextColorG, TextColorBの値がシェーダー側で読み込まれます

(コマンドの実行者が保有しているスコアが反映されます)

スコアはRGBそれぞれ0-255の範囲の値を設定可能です
***
その他にもtitleshader:hsvを実行することで

TextColorH, TextColorS, TextColorVの値からHSVで色を(H:0-360,S:0-255,V:0-255)

titleshader:decimalを実行することで

TextColorDecimalにて十進数から色を設定可能です(Decimal:0-16777215)
***
シェーダー側ではスコアが色として読み込まれ

vertexColor.rgbに正規化された0.0-1.0の範囲で値が反映されます

また、Shadertoyで一般的に使用されるiMouse,iTime変数がシェーダーで呼び出された場合
* vertexColor.xy→iMouse
* vertexColor.z→iTime

で値が反映されます

titleshader:timeファンクションを使用した際には、

"コマンド実行時を0.0としてカウントされる秒数"としてiTimeを使うことができます
```
/function titleshader:time {id:0}
```
