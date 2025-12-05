#!/bin/bash

# OneDriveキャッシュリセットスクリプト
# 
# このスクリプトは、OneDriveのキャッシュとインデックスを削除して再設定します。
# ローカルファイルやクラウド上のファイルには影響しません。

set -euo pipefail

# 色の定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ログ関数
log_info() {
    echo -e "${GREEN}ℹ️  $1${NC}"
}

log_warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# タイトル表示
echo "=========================================="
echo "OneDrive キャッシュリセットスクリプト"
echo "=========================================="
echo ""

# ステップ1: OneDriveプロセスの確認
log_info "ステップ1: OneDriveプロセスの確認中..."

ONEDRIVE_PROCESSES=$(ps aux | grep -iE "(OneDrive|onedrive)" | grep -v grep | grep -vE "(zsh|bash|reset-onedrive)" || true)

if [ -n "$ONEDRIVE_PROCESSES" ]; then
    log_error "OneDriveプロセスが実行中です。"
    echo ""
    echo "実行中のプロセス:"
    echo "$ONEDRIVE_PROCESSES"
    echo ""
    log_warn "OneDriveアプリを完全に終了してから、再度このスクリプトを実行してください。"
    echo ""
    echo "終了方法:"
    echo "1. メニューバーのOneDriveアイコンを右クリック → 終了"
    echo "2. Activity Monitorで 'OneDrive' を検索 → 強制終了"
    exit 1
fi

log_info "✅ OneDriveプロセスは停止しています"

# ステップ2: キャッシュディレクトリの確認
CACHE_DIR="$HOME/Library/Containers/com.microsoft.OneDrive-mac/Data/Library/Application Support/OneDrive"

if [ ! -d "$CACHE_DIR" ]; then
    log_warn "キャッシュディレクトリが見つかりません: $CACHE_DIR"
    log_info "OneDriveがインストールされていないか、既に削除されている可能性があります。"
    exit 0
fi

log_info "キャッシュディレクトリ: $CACHE_DIR"

# ステップ3: バックアップの作成
log_info "ステップ2: バックアップの作成中..."

BACKUP_DIR="$HOME/Desktop/OneDrive_Cache_Backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

if [ -d "$CACHE_DIR" ]; then
    log_info "バックアップ先: $BACKUP_DIR"
    cp -R "$CACHE_DIR" "$BACKUP_DIR/" 2>/dev/null || {
        log_warn "バックアップ中にエラーが発生しましたが、続行します..."
    }
    log_info "✅ バックアップ完了"
else
    log_warn "キャッシュディレクトリが存在しないため、バックアップをスキップします"
fi

# ステップ4: 削除対象の確認
log_info "ステップ3: 削除対象の確認中..."

ITEMS_TO_DELETE=()

# settingsディレクトリ内を確認
SETTINGS_DIR="$CACHE_DIR/settings"
if [ -d "$SETTINGS_DIR" ]; then
    [ -d "$SETTINGS_DIR/Business1" ] && ITEMS_TO_DELETE+=("settings/Business1")
    [ -d "$SETTINGS_DIR/Business2" ] && ITEMS_TO_DELETE+=("settings/Business2")
    [ -d "$SETTINGS_DIR/Business3" ] && ITEMS_TO_DELETE+=("settings/Business3")
    [ -d "$SETTINGS_DIR/Personal" ] && ITEMS_TO_DELETE+=("settings/Personal")
    
    # settings内のデータベースファイルを確認
    shopt -s nullglob
    for file in "$SETTINGS_DIR"/*.sqlite "$SETTINGS_DIR"/*.db "$SETTINGS_DIR"/*.cache "$SETTINGS_DIR"/index.*; do
        ITEMS_TO_DELETE+=("settings/$(basename "$file")")
    done
    shopt -u nullglob
fi

# ルートディレクトリ内も確認（旧構造の場合）
[ -d "$CACHE_DIR/Business1" ] && ITEMS_TO_DELETE+=("Business1")
[ -d "$CACHE_DIR/Business2" ] && ITEMS_TO_DELETE+=("Business2")
[ -d "$CACHE_DIR/Business3" ] && ITEMS_TO_DELETE+=("Business3")
[ -d "$CACHE_DIR/Personal" ] && ITEMS_TO_DELETE+=("Personal")

# ルートディレクトリのファイルパターンの確認
shopt -s nullglob
for file in "$CACHE_DIR"/*.sqlite "$CACHE_DIR"/*.db "$CACHE_DIR"/*.cache "$CACHE_DIR"/index.*; do
    ITEMS_TO_DELETE+=("$(basename "$file")")
done
shopt -u nullglob

if [ ${#ITEMS_TO_DELETE[@]} -eq 0 ]; then
    log_warn "削除対象が見つかりませんでした。"
    log_info "キャッシュは既に削除されているか、空の可能性があります。"
    exit 0
fi

echo ""
log_info "以下の項目を削除します:"
for item in "${ITEMS_TO_DELETE[@]}"; do
    echo "  - $item"
done
echo ""

# ステップ5: 確認プロンプト
read -p "削除を実行しますか？ (y/N): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "キャンセルされました。"
    exit 0
fi

# ステップ6: キャッシュの削除
log_info "ステップ4: キャッシュの削除中..."

# settingsディレクトリ内の削除
SETTINGS_DIR="$CACHE_DIR/settings"
if [ -d "$SETTINGS_DIR" ]; then
    [ -d "$SETTINGS_DIR/Business1" ] && rm -rf "$SETTINGS_DIR/Business1" && log_info "  ✅ settings/Business1 削除完了"
    [ -d "$SETTINGS_DIR/Business2" ] && rm -rf "$SETTINGS_DIR/Business2" && log_info "  ✅ settings/Business2 削除完了"
    [ -d "$SETTINGS_DIR/Business3" ] && rm -rf "$SETTINGS_DIR/Business3" && log_info "  ✅ settings/Business3 削除完了"
    [ -d "$SETTINGS_DIR/Personal" ] && rm -rf "$SETTINGS_DIR/Personal" && log_info "  ✅ settings/Personal 削除完了"
    
    # settings内のデータベースファイルの削除
    shopt -s nullglob
    for file in "$SETTINGS_DIR"/*.sqlite "$SETTINGS_DIR"/*.db "$SETTINGS_DIR"/*.cache "$SETTINGS_DIR"/index.*; do
        rm -f "$file" && log_info "  ✅ settings/$(basename "$file") 削除完了"
    done
    shopt -u nullglob
fi

# ルートディレクトリ内の削除（旧構造の場合）
[ -d "$CACHE_DIR/Business1" ] && rm -rf "$CACHE_DIR/Business1" && log_info "  ✅ Business1 削除完了"
[ -d "$CACHE_DIR/Business2" ] && rm -rf "$CACHE_DIR/Business2" && log_info "  ✅ Business2 削除完了"
[ -d "$CACHE_DIR/Business3" ] && rm -rf "$CACHE_DIR/Business3" && log_info "  ✅ Business3 削除完了"
[ -d "$CACHE_DIR/Personal" ] && rm -rf "$CACHE_DIR/Personal" && log_info "  ✅ Personal 削除完了"

# ルートディレクトリのファイルの削除
shopt -s nullglob
for file in "$CACHE_DIR"/*.sqlite "$CACHE_DIR"/*.db "$CACHE_DIR"/*.cache "$CACHE_DIR"/index.*; do
    rm -f "$file" && log_info "  ✅ $(basename "$file") 削除完了"
done
shopt -u nullglob

log_info "✅ キャッシュ削除完了"

# ステップ7: 完了メッセージ
echo ""
echo "=========================================="
log_info "キャッシュリセットが完了しました！"
echo "=========================================="
echo ""
log_info "次のステップ:"
echo "1. OneDriveアプリを起動してください"
echo "   - Finder → /Applications/Microsoft OneDrive.app"
echo "   - または Spotlight検索で「OneDrive」"
echo ""
echo "2. 初回スキャンが自動的に開始されます"
echo "   - 進行状況はメニューバーのOneDriveアイコンで確認できます"
echo "   - 以前の.git地獄がないため、数分で完了するはずです"
echo ""
echo "3. 同期状態を確認してください"
echo "   - メニューバーのOneDriveアイコン → 設定 → アカウント → 同期の問題"
echo ""
log_info "バックアップは以下に保存されています:"
echo "  $BACKUP_DIR"
echo ""
