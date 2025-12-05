# 環境構造と依存関係

更新日: 2025-12-04

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

## 移動履歴

- 2025-12-04: OneDrive切り離し、`/Users/tennigo/obs/` へ移行。`projects` 等は `/Users/tennigo/dev/` に集約しシンボリックリンクで参照。
