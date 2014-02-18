
   - mini mqo Viewer -

                Copyright (c) 2005 hheaven.


■更新履歴■
　２分割catmull-clarkに対応

　mmcに以下のものを追加しました
　 @LayerdEnable,TRUE　　透過モードで起動
　 @ReflashEnable,TRUE　 常に更新で起動
　 @RollEnable,TRUE　　　自動回転で起動
　鏡面に対応
　平行移動がおかしかったので修正

　mmViewer.cfgに RButtonRange,5 を追加 右クリックの半径を指定します(pix)
　右クリックとでコンテキストメニューを開くように変更
　コンテキストメニューに「常に更新」を追加
　　mmv_timeとあわせてuvスクロールとか・・・
　平行移動の速度をなんとなく、ドラッグにあわせてみた
　uniform int mmv_texture_enable; mmv_tex0が存在する場合 !0
　uniform int mmv_alpha_enable;   mmv_tex1が存在する場合 !0
　uniform int mmv_width;          表示領域の幅(pix)
　uniform int mmv_height;         表示領域の高さ(pix)
　uniform int mmv_time;           起動してからの経過時間(ms)
　mmv_tex0,mmv_tex1が2Pass以降正常になっていなかったのを修正　ほかにも影響出てたかも

　周囲光の扱いがおかしかったのを修正（明るくなってた）

　設定ファイル.mmcを読み込むようにしました
　mqoと同じ名前の.mmcを読み込みます。
　 @BGColor,255,255,255 でBGのカラーが変更できます
　レイヤー表示のプリセットを指定できるようにしました。
　　プリセットがある場合左上にウインドウが出ます
　　一番左はデフォルトの状態(mqoで指定された状態)です　テンキーでも指定可
　　デフォルト（０番）を除く　１～９まで指定できます
   .mmcで指定します
　 @LayerPreset,obj1,1,0,2 で obj1のレイヤーを
　 プリセット_1では表示
   プリセット_2では非表示
　 プリセット_3では０番と同じ表示　の指定になります
　 何も指定してないプリセットは2となります。

　スペキュラの扱いを2.3LEから2.4β準拠に変更

　右下ドラッグでウインドウの拡大縮小
　BMP 1bit対応
　Susie Plugin(spi)に対応
　　exeと同じフォルダに置いてあるspiを使用します
　　spiで読めるデータの場合spiで読んでしまうのでpngやtgaの32bitを使いたい場合は注意
　　(spiは基本的に24bitのデータにして開きます)

　アーカイブファイルだとＳＳが撮れなかったのを修正
　ＳＳのファイル名を"name_年月日時分秒"に変更

　uniform int mmv_pass;　を追加
　　現在ののpass番号が入ってます
　mms に NextPass, FrontFace を追加
　　@FrontFace,CW で面の向きが反転します
　NextPassを指定するごとに描画を１回増やします。
　　@NextPass,COPY で直前Passの設定した値を引き継ぎます
　　@NextPass,NEW で新規設定です

　@TexFilter,@ZWrite,@DepthTest,@AlphaTestEnable,@AlphaTest をシェーダーが使えない
　状況でも適用するよう変更（@BlendMode は透過モードの絡みで保留）
　テクスチャが１枚しか貼れない場合カラーマップのみで表示するように変更
　　(OpenGL1.1対応？)
　mms に AlphaTestEnable, AlphaTest を追加
　　@AlphaTestEnable,FALSE でアルファテストを実行しません
　　@AlphaTest,GREATER,0.0 で通常のアルファテスト
　　NEVER, LESS, EQUAL, LEQUAL, GREATER, NOTEQUAL, ALWAYS
　　0.0～1.0が指定可能
　アルファ値が0の場合描画をしないように変更(2.4beta仕様)
　透過表示時tabキーでアルファ値付プリントスクリーン

　ウインドウにD&Dした場合、同じウインドウに追加で表示されるようにしました
　使わないメモリをモデルロード後開放
　テクスチャを共有して使うように変更

　mms に DepthTest を追加
　　@DepthTest,LESS で通常のＺテスト
　　NEVER, LESS, EQUAL, LEQUAL, GREATER, NOTEQUAL, ALWAYS　が指定可能
　リードオンリーのフォルダにexeを置いて実行した場合落ちていたのを修正

　32bit tga のアルファの扱いをメタセコ2.4beta以降に準拠

　32bit tgaの読み込みを修正
　mms に BlendMode, ZWrite, TexFilter を追加
　　@BlendMode,ADD で加算表示になります
　  @ZWrite,FALSE でＺ値を書き込まないようになります
　  @TexFilter,NEAREST でテクスチャのバイリニア表示をしないようになります
　ポストエフェクトも実装したけど、インターフェースがまとまらないので非公開

　テクスチャが２枚以下しか貼れないボードでの不具合を修正
　mmEncrypt の暗号ファイル .mmeに対応
　カメラの初期位置計算を変更

　バーテックシェーダーが使えてフラグメントシェーダーが使えないボードを
　シェーダの使えないボード判定に修正

　ライト移動追加
　バージョン表示追加
　.mms mmViewer.cfg の書式変更
　（今のとこ古いのでもつかえけど、そのうち削除予定）
　接空間のタンジェントベクトルを追加（計算怪しいかも）
　シェーダーの使えるマシンはglBlendFuncSeparateを使うように変更

　２の累乗サイズ以外のテクスチャ対応
　.exeと同じフォルダにmmViewer.cfgファイルを置くとアンチエイリアス表示
　（いまのとこ空ファイルで可　Radeon X300だと輪郭がおかしいので非デフォルト）

　.mmzを.zipファイルとして読み込み
　.zipファイルに対応
　.net 2003に変更

　コンスタント対応
　マテリアルαが効かなくなってたの修正

　頂点カラー対応
　シェーダーのエラーをデバッグログに出力
　中ドラッグを変更
　複数ファイル起動
　直接起動時「ファイルを開く」ダイアログ表示
　ViewへD&Dの許可
　シェーダー終了処理が甘かったの修正
　内部マルチウインドウ化

　bmpのx,yサイズが逆だったの修正
　非透過時のホイル操作修正
　GLSLによるシェーダーを使うEXモード追加(OpenGL 1.5)

　非透過表示をデフォルトに
　glBlendFuncSeparate使うのヤメ　以前の処理に

　Icon設定(Powered by ntny)

　glBlendFuncSeparate(OpenGL 1.4) に変更　使えないドライバは以前のまま
　デバックログをexeのフォルダに変更 debug_log.txt
　絶対パス対応
　最前面に表示モード
　非透過モード
　自動回転モード

　jpg対応
　32bit24bit(RLE)Tga対応
　4bitbmp修正

　初期カメラ情報修正
　出力時のアルファ値を修正　描画負荷増加
　描画順を修正　ひとつのオブジェクトにまとめてた
　アルファマップ対応　(OpenGL 1.3)
　8bit4bitbmp修正　インデックスがズレてた
　平行移動変更

　win2000以前は非透過モードで起動
　右ダブルクリックで終了
　8bit4bit bmp 追加
　やっつけ平行移動
　ウインドウ拡大縮小操作変更
　テクスチャファイルをクローズしてなかったの対処　まだあった orz
　オブジェクト非表示対応
　ホイール対応
　拡大縮小操作メタセコ準拠

　テクスチャにpng追加
　ctrlで非レイヤードウインドウ表示
　C:\Documents and Settings\(ユーザー名)\GlTest_log.txt にデバックログ作成
　エラーメッセージ表示
　フルパスにスペースが入ってると読めないの対処
　テクスチャファイルをクローズしてなかったの対処
　４角ポリゴン対応
　

■現状の仕様■
　テクスチャ
　　bmp 24bit8bit4bit1bit
　　tga 32bit24bit(RLE)
　　png
　　jpg

　　Susie Plugin（exeと同じフォルダに.spiを置く）


■操作■

　起動方法
　　exeへ .mqo .zip .mme をD&D

　終了方法
　　タスクバー右クリック→閉じる
　　Alt+F4
　　左ダブルクリック→閉じる
　　右クリック→閉じる

　左ドラッグ　　　　　　ウインドウ移動
　右ドラッグ　　　　　　回転
　中ドラッグ　　　　　　平行移動
　左右ドラッグ（上下）　拡大縮小
　ホイール　　　　　　　拡大縮小
　SHIFT+左ドラッグ　　　XZ移動
　SHIFT+右ドラッグ　　　Y移動
　CTRL+左ドラッグ 　　　ウインドウ拡大縮小
　CTRL+右ドラッグ 　　　ライト移動
　CTRL押し中　　　　　　非透過表示

　左ダブルクリックメニュー
　　最前面表示モード　切り替え
　　自動回転モード　　切り替え
　　透過表示モード　　切り替え

　　終了

 　スクリーンショット
 　　透過表示時　　　　tab


■ＦＡＱ■
　Q. 「OpenGL Ver. 1.?.?」ってメッセージボックスが出て終了する
　A. ドライバがマルチテクスチャに対応しないと思われます。
　　 最新のドライバを入れたら動く場合もあったりなかったり

  Q. 表示する前に落ちた
  A. mmViewer.cfgの@MultiSample,16を@MultiSample,0にしてみて下さい。

  Q'.それでも落ちる
  A'.謎げ

　Q. Radeonでアンチエイリアス表示がおかしいです
　A. Radeonはαにだけアンチエイリアスを掛けてくれないらしく表示がおかしくなります
　　 ATIに文句言ってやって下さい。


このソフトの転載・配布等は常識の範囲で自由にやってもらってかまいません。
このソフトを使用したことによる損害等に作者は一切保障いたしません。


IconDesigen _ Powered by ntny

LICENSE
  libpng   Copyright (C) 1998-2001 Glenn Randers-Pehrson.
  libjpeg  Copyright (C) 1991-1998, Thomas G. Lane.
  zlib     Copyright (C) 1995-1998 Jean-loup Gailly and Mark Adler.
