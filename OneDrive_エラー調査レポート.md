# OneDrive同期エラー調査レポート

## 調査日時
2025年12月3日

## 発見された問題

### 1. 権限の問題（最も可能性が高い原因）
- **問題**: `projects`フォルダ内の複数のサブフォルダが権限700（`drwx------`）になっている
- **影響**: OneDriveは他のユーザー（システム）が読み取れる権限を必要とする場合がある
- **該当フォルダ**:
  - `projects/tax-stock-backtest` およびそのサブフォルダ
  - `projects/archive/deepseek-ocr` およびそのサブフォルダ
  - `projects/deepseek-ocr` の一部サブフォルダ

### 2. ファイル数の問題
- **問題**: `research-vault`フォルダに約85,500個のファイルが存在
- **サイズ**: 2.7GB
- **影響**: ファイル数が多すぎるとOneDriveの同期に時間がかかり、エラーが発生しやすくなる

### 3. ファイル名・パスの問題
- **結果**: 使用できない文字（`<>:"|?*`）を含むファイル名は見つからなかった
- **パス長**: 最長でも100文字程度で、問題なし

## 推奨される対処方法

### ステップ1: バックアップ（最重要）
```bash
# バックアップ先（OneDrive外）を指定
BACKUP_DIR="$HOME/Desktop/OneDrive_Backup_$(date +%Y%m%d)"

# 問題のあるフォルダをバックアップ
mkdir -p "$BACKUP_DIR"
cp -R ~/Library/CloudStorage/OneDrive-個人用/obsidian/projects "$BACKUP_DIR/"
cp -R ~/Library/CloudStorage/OneDrive-個人用/obsidian/research-vault "$BACKUP_DIR/"
```

### ステップ2: 権限の修正（安全な方法）
```bash
# 権限を755（読み取り可能）に変更
cd ~/Library/CloudStorage/OneDrive-個人用/obsidian
find projects -type d -perm 700 -exec chmod 755 {} \;
find projects -type f -perm 600 -exec chmod 644 {} \;
```

### ステップ3: OneDriveの再同期
1. OneDriveアプリを完全に終了
2. 再起動
3. メニューバーから「今すぐ同期」を実行

### ステップ4: エラーの確認
- OneDriveのメニューバーアイコンをクリック
- 「設定」→「アカウント」→「同期の問題」を確認

## 注意事項

⚠️ **重要**: OneDriveを再インストールする前に、必ずバックアップを取ること
⚠️ 権限を変更する前に、バックアップを確認すること
⚠️ 変更後、ファイルが正しく同期されるまで待つこと

## 次のステップ

1. バックアップを実行
2. 権限を修正
3. 同期状態を確認
4. 問題が解決しない場合のみ、OneDriveの再インストールを検討

