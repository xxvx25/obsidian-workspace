# 環境構造と依存関係

更新日: 2025-12-05

## ディレクトリ構造

### 基準ディレクトリ
- `/Users/tennigo/obs/` - Obsidianワークスペースのルート（OneDrive切り離し済み）

### プロジェクト構造

```
/Users/tennigo/obs/
├── knowledge-vault/             # External Brain（旧 external_brain2）
├── research-vault/
├── projects -> /Users/tennigo/dev/projects
├── mcp-servers.json -> /Users/tennigo/dev/mcp-servers.json
├── package.json -> /Users/tennigo/dev/package.json
├── pnpm-lock.yaml -> /Users/tennigo/dev/pnpm-lock.yaml
├── pyproject.toml -> /Users/tennigo/dev/pyproject.toml
└── uv.lock -> /Users/tennigo/dev/uv.lock

/Users/tennigo/dev/
├── projects/
│   ├── code/                    # コードプロジェクト（deepseek-ocr, ocr-evaluation, tax-stock-backtest など）
│   └── tools/                   # 共通ツール群（zotero-scripts, textlint-rules など）
└── tools -> /Users/tennigo/dev/projects/tools
```

## 依存関係管理

### Node.js依存関係（PNPM）

**管理方法**: PNPMを使用して共通ストアからハードリンク

**プロジェクト例**:
- `/Users/tennigo/obs/` - textlint関連
- `/Users/tennigo/dev/projects/tools/zotero-scripts/` - textlint関連

**設定**:
- PNPMストア: `~/.pnpm-store`（デフォルト）
- `package-lock.json`は`pnpm-lock.yaml`に置き換え

### Python依存関係（uv）

**管理方法**: 各プロジェクトで`uv`を使用

**プロジェクト**:
- `/Users/tennigo/dev/projects/tools/zotero-scripts/` - `pyproject.toml`, `.venv/`
- `/Users/tennigo/dev/projects/tools/zotero-obsidian-pipeline/` - `pyproject.toml`, `.venv/`
- `/Users/tennigo/dev/projects/code/tax-stock-backtest/` - `pyproject.toml`, `env/`
- `/Users/tennigo/dev/projects/code/ocr-evaluation/` - `pyproject.toml`, `.venv/`

### グローバルCLIツール（npm）

**管理方法**: npmでグローバルインストール

**ツール**:
- **Gemini CLI** (`@google/gemini-cli`): Google Gemini API用CLIツール
  - インストール: `npm install -g @google/gemini-cli`
  - バージョンアップ: `npm update -g @google/gemini-cli`
  - 認証: `GEMINI_API_KEY`環境変数または`gemini config set api_key`
- **Codex CLI** (`@openai/codex`): OpenAI Codex API用CLIツール
  - インストール: `npm install -g @openai/codex@latest`
  - バージョンアップ: `npm install -g @openai/codex@latest`
  - 認証: ChatGPT Plus/Pro/Business/Edu/EnterpriseアカウントまたはOpenAI APIキー
  - **Windows対応**: v0.22.0以降でWindowsサポートが改善（実験的サポート）
  - **起動**: `codex` コマンドでインタラクティブなTUIセッションを開始
  - **参考**: 
    - [公式ドキュメント](https://developers.openai.com/codex/cli/)
    - Windowsでのインストール手順: [Qiita記事](https://qiita.com/youtoy/items/57efea9238f07ac15f37)（v0.22.0で問題解決済み）
  - **Cursorでの確認方法**:
    - インストール確認スクリプト: `docs/scripts/check-codex-install.ps1` を実行
    - `npm bin -g` の出力パスが環境変数PATHに含まれている必要があります
    - インストール後、`codex --version` でバージョン確認
    - Cursorを再起動して環境変数を再読み込み

### 仮想環境の場所

- 各プロジェクト内に保持（`venv/`, `.venv/`, `env/`など）
- `zotero-scripts/venv-zotero-ft/` - 旧`~/venv/zotero-ft/`から移動

## 環境変数

### 必須環境変数

```bash
# External Brain のルートディレクトリ
export EXTERNAL_BRAIN_ROOT="${HOME}/obs/knowledge-vault"

# Zoteroスクリプトのルートディレクトリ
export ZOTERO_SCRIPTS_ROOT="${HOME}/dev/projects/tools/zotero-scripts"

# OCR出力ディレクトリ
export OCR_OUTPUT_DIR="${EXTERNAL_BRAIN_ROOT}/temp"
```

## MCP設定ファイルの運用方針

### 設定ファイルの種類

1. **`mcp-servers.json`** (シンボリックリンク)
   - パス: `/Users/tennigo/obs/mcp-servers.json` → `/Users/tennigo/dev/mcp-servers.json`
   - 用途: 汎用的なMCP設定（環境変数参照形式）
   - 編集: `/Users/tennigo/dev/mcp-servers.json` を直接編集

2. **`mcp-servers-TENのノートブックコンピュータ.json`** (ホスト固有)
   - パス: `/Users/tennigo/obs/mcp-servers-TENのノートブックコンピュータ.json`
   - 用途: このマシン固有の設定（絶対パス指定）
   - 編集: ルート直下のファイルを直接編集

### 運用ルール

- **基本方針**: `mcp-servers.json` を基準とし、環境変数（`${ZOTERO_SCRIPTS_ROOT}`等）を使用
- **ホスト固有設定**: 環境変数が設定されていない場合や、マシン固有の調整が必要な場合は `mcp-servers-TENのノートブックコンピュータ.json` を使用
- **設定の同期**: 新しいMCPサーバーを追加する際は、両方のファイルに反映するか、どちらを基準とするか明確にする
- **パス修正**: tokyo-law-review MCPのパスは `.cursor/rules/u-tokyo_law_review_style/` が正しい（typo: `u-tokto` → `u-tokyo`）

## 移動履歴

- 2025-12-04: OneDrive切り離し、`/Users/tennigo/obs/` へ移行。`projects` 等は `/Users/tennigo/dev/` に集約しシンボリックリンクで参照。
- 2025-12-05: `.gitignore`拡充、MCP設定ファイルの運用方針を明確化。
- 2025-12-05: Gemini CLIとCodex CLIの依存関係情報を追加。
