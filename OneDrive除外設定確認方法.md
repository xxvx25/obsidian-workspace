# OneDrive除外設定の確認方法

## 調査結果サマリー

### 確認した内容
1. ✅ **plist設定ファイル**: 除外設定は見つかりませんでした
2. ✅ **環境変数・シェル設定**: 除外設定は見つかりませんでした
3. ✅ **SelectiveSyncテーブル**: 現在は0件（除外設定なし）
4. ⚠️ **データベース内の他のテーブル**: 詳細確認が必要

## 除外設定が保存されている可能性がある場所

### 1. データベース内の設定

#### Personalアカウント
```bash
# データベースの場所
~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application Support/OneDrive/settings/Personal/SyncEngineDatabase.db

# 確認方法
sqlite3 "上記のパス"
.tables
SELECT * FROM od_SelectiveSync_Records;
```

#### Businessアカウント
```bash
# データベースの場所
~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application Support/OneDrive/settings/Business1/SyncEngineDatabase.db
~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application Support/OneDrive/settings/Business2/SyncEngineDatabase.db
```

### 2. 確認すべきテーブル

- `od_SelectiveSync_Records`: 選択的同期の設定（現在は0件）
- `od_ClientFolder_Records`: クライアント側のフォルダ情報
- `od_ClientFile_Records`: クライアント側のファイル情報
- `od_UnrealizedFile_Records`: 未実現ファイル（同期されていないファイル）の記録

### 3. 手動での確認方法

#### 方法1: OneDriveアプリのGUI
1. OneDriveのメニューバーアイコンをクリック
2. 「設定」→「アカウント」を開く
3. 各アカウントの「フォルダの選択」を確認
4. 除外されているフォルダがないか確認

#### 方法2: Finderから確認
1. 問題のあるフォルダ（projects、research-vault）を右クリック
2. 「OneDrive」メニューを確認
3. 「このフォルダを同期しない」などのオプションがあるか確認

#### 方法3: データベースの詳細確認
```bash
# Personalアカウントのデータベースを確認
sqlite3 ~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application\ Support/OneDrive/settings/Personal/SyncEngineDatabase.db

# すべてのテーブルを確認
.tables

# 各テーブルのスキーマを確認
.schema od_ClientFolder_Records
.schema od_UnrealizedFile_Records

# 問題のあるフォルダの情報を検索
SELECT * FROM od_ClientFolder_Records WHERE path LIKE '%projects%';
SELECT * FROM od_UnrealizedFile_Records WHERE path LIKE '%projects%';
```

## 除外設定を解除する方法

### 方法1: OneDriveアプリから解除
1. OneDriveのメニューバーアイコンをクリック
2. 「設定」→「アカウント」→「フォルダの選択」
3. 除外されているフォルダのチェックを外す

### 方法2: データベースから直接削除（注意が必要）
```bash
# ⚠️ バックアップを取ってから実行
cp ~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application\ Support/OneDrive/settings/Personal/SyncEngineDatabase.db ~/Desktop/SyncEngineDatabase_backup.db

# 除外設定を削除（例）
sqlite3 ~/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application\ Support/OneDrive/settings/Personal/SyncEngineDatabase.db "DELETE FROM od_SelectiveSync_Records WHERE resourceID LIKE '%projects%';"
```

## 注意事項

⚠️ **重要**: 
- データベースを直接編集する前に、必ずバックアップを取ってください
- OneDriveアプリを完全に終了してからデータベースを操作してください
- データベースを編集した後は、OneDriveアプリを再起動してください

## 次のステップ

1. OneDriveアプリのGUIで「フォルダの選択」を確認
2. 問題のあるフォルダが除外されているか確認
3. 除外されていた場合は、チェックを外して同期を再開
4. それでも解決しない場合は、データベースの詳細を確認

