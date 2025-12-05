# OneDrive設定確認レポート

## 調査日時
2024年12月3日

## 確認した設定ファイル

### 1. 設定ファイルの場所
- **Preferences (plist)**:
  - `~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Preferences/com.microsoft.OneDrive-mac.plist`
  - `~/Library/Group Containers/UBF8T346G9.OneDriveSyncClientSuite/Library/Preferences/UBF8T346G9.OneDriveSyncClientSuite.plist`

- **Application Support**:
  - `~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application Support/OneDrive/settings/`

### 2. 確認した内容

#### plistファイル
- 除外設定（exclude/ignore/filter）は見つかりませんでした
- 主な設定はアカウント情報、同期状態、機能フラグなど

#### データベースファイル
- `SyncEngineDatabase.db`: 同期エンジンのデータベース
- `SettingsDatabase.db`: 設定データベース
- これらのデータベースには除外設定が含まれている可能性があります

#### JSON設定ファイル
- `ECSConfig.json`: Enterprise Configuration Serviceの設定
- 除外設定が含まれている可能性があります

### 3. 除外設定の可能性がある場所

1. **データベース内の設定**
   - `SyncEngineDatabase.db`内のテーブル
   - `SettingsDatabase.db`内のテーブル

2. **コマンドライン設定**
   - 環境変数（確認済み：OneDrive関連の環境変数は見つかりませんでした）
   - シェル設定ファイル（確認済み：除外設定は見つかりませんでした）

3. **OneDriveアプリ内の設定**
   - GUIで設定できない項目は、データベースや設定ファイルに直接書き込まれている可能性があります

### 4. 次のステップ

除外設定を確認するには、以下の方法を試してください：

1. **データベースの詳細確認**
   ```bash
   sqlite3 ~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application\ Support/OneDrive/settings/Personal/SyncEngineDatabase.db
   .tables
   # 各テーブルの内容を確認
   ```

2. **OneDriveアプリのログ確認**
   - OneDriveアプリのメニューバーから「設定」→「アカウント」→「同期の問題」を確認
   - コンソールアプリでOneDriveのログを確認

3. **手動での除外設定の確認**
   - Finderで問題のあるフォルダを右クリック
   - 「OneDrive」メニューから「このフォルダを同期しない」などのオプションを確認

## 注意事項

⚠️ データベースファイルを直接編集することは推奨されません
⚠️ 設定を変更する前に、必ずバックアップを取ってください

