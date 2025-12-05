# OneDriveキャッシュリセット手順

## ⚠️ 重要な注意事項

**この手順は、OneDriveのキャッシュとインデックスを削除して再設定するものです。**

- ✅ **ローカルファイルは保持されます** - 同期フォルダ内の実ファイルには影響しません
- ✅ **クラウド上のファイルも保持されます** - 削除されるのはローカルのキャッシュのみ
- ⚠️ **OneDriveアプリは必ず停止してから実行してください**

## 前提条件

1. ✅ OneDriveアプリが完全に停止していること
2. ✅ 重要なファイルのバックアップを取っていること（念のため）
3. ✅ 現在の同期状態を確認していること

## 手順

### ステップ1: OneDriveアプリの完全停止確認

```bash
# OneDriveプロセスが実行されていないことを確認
ps aux | grep -i onedrive | grep -v grep

# 何も表示されなければOK
# 表示される場合は、Activity Monitorから強制終了
```

### ステップ2: キャッシュの削除

削除する場所：
```
~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application Support/OneDrive
```

削除する内容：
- `Business1/` フォルダ
- `Business2/` フォルダ
- `Business3/` フォルダ（存在する場合）
- `Personal/` フォルダ
- `OneDrive.sqlite` ファイル
- `index.db` ファイル
- `*.cache` ファイル

**実行コマンド：**
```bash
# バックアップ先を作成（念のため）
BACKUP_DIR="$HOME/Desktop/OneDrive_Cache_Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# キャッシュディレクトリをバックアップ
CACHE_DIR="$HOME/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application Support/OneDrive"
if [ -d "$CACHE_DIR" ]; then
    cp -R "$CACHE_DIR" "$BACKUP_DIR/" 2>/dev/null || true
    echo "✅ バックアップ完了: $BACKUP_DIR"
fi

# キャッシュを削除
rm -rf "$CACHE_DIR/Business1"
rm -rf "$CACHE_DIR/Business2"
rm -rf "$CACHE_DIR/Business3"
rm -rf "$CACHE_DIR/Personal"
rm -f "$CACHE_DIR"/*.sqlite
rm -f "$CACHE_DIR"/*.db
rm -f "$CACHE_DIR"/*.cache
rm -f "$CACHE_DIR"/index.*

echo "✅ キャッシュ削除完了"
```

### ステップ3: OneDriveアプリの再起動

1. **Finder**からOneDriveアプリを起動
   - `/Applications/Microsoft OneDrive.app` をダブルクリック
   - または、Spotlight検索で「OneDrive」を検索

2. **初回スキャン**が自動的に開始されます
   - 以前の.git地獄がないため、数分で完了するはずです
   - 進行状況はメニューバーのOneDriveアイコンで確認できます

### ステップ4: 同期状態の確認

1. メニューバーのOneDriveアイコンをクリック
2. 「設定」→「アカウント」→「同期の問題」を確認
3. エラーがないことを確認

## 現在の構成（最適化済み）

現在の構成は、OneDriveのトラブルを回避するために最適化されています：

```
~/Library/CloudStorage/OneDrive-個人用/obsidian/
├── knowledge-vault/     # ノート・PDF・リサーチ
├── research-vault/      # リサーチボルト
└── docs/               # ドキュメント

~/dev/projects/         # Gitプロジェクト（OneDrive外）
~/repos/                # コード保管（OneDrive外）
```

この構成により：
- ✅ OneDriveは軽量なノートとドキュメントのみを同期
- ✅ GitプロジェクトはローカルとGitHubのみで管理
- ✅ クラウド同期の負荷が大幅に軽減

## トラブルシューティング

### 再起動後も問題が続く場合

1. **完全にアンインストールして再インストール**
   ```bash
   # OneDriveアプリを完全に削除
   rm -rf /Applications/Microsoft\ OneDrive.app
   rm -rf ~/Library/Containers/com.microsoft.OneDrive-mac
   rm -rf ~/Library/Group\ Containers/UBF8T346G9.OneDriveSyncClientSuite
   rm -rf ~/Library/Caches/OneDrive
   ```

2. **App StoreまたはMicrosoft公式サイトから再インストール**

3. **再ログインして同期を再開**

### 初回スキャンが長時間かかる場合

- ファイル数が多い場合は、数時間かかる可能性があります
- メニューバーのアイコンで進行状況を確認
- 同期が完了するまで待機してください

## 参考情報

- 過去の調査レポート：
  - `OneDrive_エラー調査レポート.md`
  - `OneDrive大量ファイルクラッシュ問題調査.md`
  - `OneDrive設定確認レポート.md`

## 実行スクリプト

安全に実行するためのスクリプトは `scripts/reset-onedrive-cache.sh` に用意されています。
