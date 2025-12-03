# 環境構造と依存関係

更新日: 2025-11-28

## ディレクトリ構造

### 基準ディレクトリ
- `/Users/tennigo/Library/CloudStorage/OneDrive-個人用/obsidian/` - Obsidianワークスペースのルート

### プロジェクト構造

```
obsidian/
├── projects/
│   ├── code/                    # コードプロジェクト
│   │   ├── zotero-scripts/      # Zoteroスクリプト集（旧~/zotero-scripts）
│   │   ├── zotero-obsidian-pipeline/  # Zotero-Obsidian連携（旧~/Projects）
│   │   ├── powerpoint-generator/     # PowerPoint生成ツール（旧~/Projects）
│   │   ├── receipt_ocr/              # レシートOCR（旧~/Projects）
│   │   ├── tax-stock-backtest/       # 投資バックテスト
│   │   ├── ocr-evaluation/           # OCR評価
│   │   └── deepseek-ocr/              # DeepSeek OCR
│   ├── tools/                   # ツール・スクリプト
│   │   ├── bin/                 # バイナリスクリプト（旧~/bin）
│   │   │   └── pdfannots2json
│   │   ├── scripts/             # 各種スクリプト
│   │   └── textlint-rules/      # textlintルール
│   └── user/                    # ユーザー固有プロジェクト
└── external_brain2/             # External Brain 2システム
```

## 依存関係管理

### Node.js依存関係（PNPM）

**管理方法**: PNPMを使用して共通ストアからハードリンク

**プロジェクト**:
- `/Users/tennigo/Library/CloudStorage/OneDrive-個人用/obsidian/` - textlint関連
- `/Users/tennigo/Library/CloudStorage/OneDrive-個人用/obsidian/projects/code/zotero-scripts/` - textlint関連

**設定**:
- PNPMストア: `~/.pnpm-store`（デフォルト）
- `package-lock.json`は`pnpm-lock.yaml`に置き換え

### Python依存関係（uv）

**管理方法**: 各プロジェクトで`uv`を使用

**プロジェクト**:
- `projects/code/zotero-scripts/` - `pyproject.toml`, `.venv/`
- `projects/code/zotero-obsidian-pipeline/` - `pyproject.toml`, `.venv/`
- `projects/code/powerpoint-generator/` - `venv/`（従来型）
- `projects/code/tax-stock-backtest/` - `pyproject.toml`, `env/`

### 仮想環境の場所

- 各プロジェクト内に保持（`venv/`, `.venv/`, `env/`など）
- `zotero-scripts/venv-zotero-ft/` - 旧`~/venv/zotero-ft/`から移動

## 環境変数

### 必須環境変数

```bash
# External Brain 2のルートディレクトリ
export EXTERNAL_BRAIN_ROOT="${HOME}/Library/CloudStorage/OneDrive-個人用/obsidian/external_brain2"

# Zoteroスクリプトのルートディレクトリ（更新済み）
export ZOTERO_SCRIPTS_ROOT="${HOME}/Library/CloudStorage/OneDrive-個人用/obsidian/projects/code/zotero-scripts"

# OCR出力ディレクトリ
export OCR_OUTPUT_DIR="${EXTERNAL_BRAIN_ROOT}/temp"
```

## 移動履歴

- 2025-11-28: 環境整理実施
  - `~/Projects/*` → `projects/code/`
  - `~/zotero-scripts` → `projects/code/zotero-scripts`
  - `~/bin/pdfannots2json` → `projects/tools/bin/pdfannots2json`
  - `~/venv/zotero-ft` → `projects/code/zotero-scripts/venv-zotero-ft`
  - グローバル`node_modules`削除、PNPMで再構築
