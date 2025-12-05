# OneDrive 再セットアップ TODO（2025-12-05）

- [ ] OneDrive を起動しサインインする（/Applications/Microsoft OneDrive.app）
- [ ] 同期先フォルダを新規で指定する（例: `~/Library/CloudStorage/OneDrive-個人用-new`）
- [ ] セットアップ時に同期対象フォルダを最小限に選択する（大容量は外す）
- [ ] 同期完了を待ち、メニューバーがチェック状態になることを確認する
- [ ] `find ~/Library/CloudStorage/OneDrive-個人用-new -name "*conflict*"` で競合ファイルを簡易チェックする
- [ ] 旧フォルダと差分を確認し、必要なファイルを新フォルダへ移動する
- [ ] 問題なく動作したら `.bak.*` を削除するか、しばらく保管する

## リポジトリ関連 TODO
- [ ] `git status` の pending 変更を確認し、必要ならコミットする（例: `.gitignore`、`knowledge-vault` の変更）
- [ ] `docs/reports` のリネーム変更をコミットして整理する
- [ ] OneDrive 再セットアップ完了後、`.bak.*` ディレクトリを削除するかバックアップ先へ移動する

詳細手順: `docs/reports/20251205_OneDrive再セットアップ手順.md`
