# WezTerm Configuration
======================

このフォルダは WezTerm のユーザー設定です。
軽量・高速な描画、VSCode/iTerm2 に近い操作感、日本語IME、シアン基調のテーマを前提に調整しています。

---

## 構成ファイル

- `wezterm.lua` 本体設定（外観/タブ/フォントなど）
- `keybinds.lua` キーバインド定義（リーダーキー、分割、コピー、全画面 など）

---

## リロード方法

- WezTerm を再起動するか、TUIで `:config reload` を実行

## 外観（Appearance）

- フォント: `font_with_fallback({ "MesloLGS NF", "Monaco", "Courier New", "Menlo", "Hiragino Sans", "Apple Color Emoji" })`
- フォントサイズ: `14.0`
- 日本語IME: `use_ime = true`
- 背景透明度: `window_background_opacity = 0.7`
- 背景ぼかし(macOS): `macos_window_background_blur = 20`
- タブ装飾: タイトルバーを隠し（`window_decorations = "RESIZE"`）、アクティブタブをシアン `#00BCD4` に強調
- カーソル色: 通常/IME合成中ともにシアン（`cursor_bg/cursor_border/compose_cursor = "#00BCD4"`、文字は黒）

---

## タブ/ペイン表示

- タブバーは複数タブ時に自動表示、境界線を非表示
- アクティブタブはシアン背景で、左右に三角装飾（`format-tab-title`）
- 既定でタブ追加ボタン/クローズボタンを非表示

---

## キーバインド（主要）

- リーダーキー: `Ctrl+q`（押下後に h/j/k/l など）
- 改行（チャット欄などで送信せず改行）: `Option+Enter`（LFを文字として挿入）
- ペイン最大化（ズーム）: `Cmd+Shift+F`
- 全画面切替: `Ctrl+Shift+F`
- コマンドパレット: `Cmd+p` または `Ctrl+Shift+p`
- 設定リロード: `Ctrl+Shift+r`
- コピー/貼り付け: `Cmd+c` / `Cmd+v`
- タブ操作: 新規 `Cmd+t`、クローズ `Cmd+w`、次/前 `Ctrl+Tab` / `Ctrl+Shift+Tab`、並べ替え `Leader + { / }`
- タブへジャンプ: `Cmd+1..9`
- ペイン分割: `Leader + d`（縦）/ `Leader + r`（横）
- ペイン移動: `Leader + h/j/k/l`
- ペイン選択UI: `Ctrl+Shift+[`（`PaneSelect`）
- ズーム（選択ペインのみ表示）: `Leader + z`
- フォントサイズ: 拡大/縮小 `Ctrl + / -`、リセット `Ctrl+0`
- コピー・検索モード: `Leader + [`（Copy Mode）

---

## フォントについて

- VSCode の `editor.fontFamily` に合わせ、MesloLGS → Monaco → Courier New → Menlo の順でフォールバック
- 日本語/絵文字の欠字対策で「Hiragino Sans」「Apple Color Emoji」を末尾に追加

---

## Tips / よくある質問

- Option+Enter が改行にならない: `keybinds.lua` で `SendString("\n")` を割り当て済み。リロード後に再試行
- IMEの下線色が緑: `compose_cursor` をシアンに設定済み
- タブ色を変えたい: `wezterm.on("format-tab-title", ...)` で `background` のカラーコードを変更
- 他アプリ風のキーへ変更したい: `keybinds.lua` に追記（例: `SUPER+p` を別アクションへ）

---

## 既知の注意点

- `Cmd` 系は WezTerm が受け取り可能ですが、SSH先の TUI/Vim には直接届かない場合があります（必要に応じて `SendKey`/`SendString` で中継）
- macOS のフルスクリーン（`Ctrl+Shift+F`）はスペース（デスクトップ）をまたぐ切替のため、アプリ設定でアニメーションが入る場合があります

---

## 編集場所

- 全体: `~/.config/wezterm/wezterm.lua`
- キー: `~/.config/wezterm/keybinds.lua`

---

## 反映手順

- 変更後に `:config reload` で即時反映、または WezTerm を再起動
