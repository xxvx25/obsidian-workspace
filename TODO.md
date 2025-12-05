# OneDrive 再セットアップ TODO（2025-12-05）

- [x] OneDrive を起動しサインインする（/Applications/Microsoft OneDrive.app）✅ 2025-12-06完了
- [x] 同期先フォルダを確認する（例: `~/Library/CloudStorage/OneDrive-個人用-new`）✅ 既存パスを使用
- [x] セットアップ時に同期対象フォルダを最小限に選択する（大容量は外す）✅ 完了
- [x] 同期完了を待ち、メニューバーがチェック状態になることを確認する ✅ 完了
- [x] `find ~/Library/CloudStorage/OneDrive-個人用 -name "*conflict*"` で競合ファイルを簡易チェックする ✅ 競合なし
- [x] 旧フォルダと差分を確認し、必要なファイルを新フォルダへ移動する ✅ データ移行不要
- [x] 問題なく動作したら `.bak.*` を削除するか、しばらく保管する ✅ バックアップ整理済み

## リポジトリ関連 TODO
- [x] `git status` の pending 変更を確認し、必要ならコミットする（例: `.gitignore`、`knowledge-vault` の変更）✅ 2025-12-06完了
- [x] `docs/reports` のリネーム変更をコミットして整理する ✅ 変更なし（リネームは実施されていない）

### 注意事項
- `research-vault` サブモジュールにuntracked contentがあります。サブモジュール側で対応してください。

詳細手順: `docs/reports/20251205_OneDrive再セットアップ手順.md`
