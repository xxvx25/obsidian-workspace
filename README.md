# Obsidian ワークスペース Git レイアウト

このリポジトリは、ワークスペース構成・ドキュメント・シンボリックリンクを最小限に管理するためのルートです。ノートコンテンツとコードは分離し、クラウド同期トラブルを避けることを目的としています。

## ディレクトリ構造（概要）
```
/Users/tennigo/obs/
├── docs/                     # ガイド・構成メモ・レポートを集約
│   ├── guides/AGENTS.md      # コントリビュータガイド
│   ├── workspace/ENVIRONMENT_STRUCTURE.md
│   └── reports/*.md          # OneDrive等の調査・手順書
├── archives/                 # アーカイブ済みファイル（例: バックアップzip）
├── shell/                    # プロンプト設定など（例: starship.toml）
├── projects -> /Users/tennigo/dev/projects
├── knowledge-vault/          # 外部vault（別リポジトリ、ルートからは無視）
├── research-vault/           # 研究用vault（別リポジトリ、ルートからは無視）
├── mcp-servers.json -> /Users/tennigo/dev/mcp-servers.json
├── package.json -> /Users/tennigo/dev/package.json
├── pnpm-lock.yaml -> /Users/tennigo/dev/pnpm-lock.yaml
├── pyproject.toml -> /Users/tennigo/dev/pyproject.toml
└── uv.lock -> /Users/tennigo/dev/uv.lock
```

## 運用方針
- ボルト内ではなく、`/Users/tennigo/dev/projects/**` でインストール/ビルド/実行を行う。コード変更も各プロジェクトリポジトリ側で管理。
- 重い成果物（`node_modules`、`.venv`、`env`、`dist`、`build`、`.cache`、`logs/`）は追跡しない。
- 新しいボルトを追加する場合は独立リポジトリとして管理し、`.gitignore` に追加する。
- ルート直下には設定・ドキュメント・シンボリックリンクのみを置き、その他の資料は `docs/` か `archives/` に整理する。

## MCP設定ファイルの運用
- **基準ファイル**: `mcp-servers.json`（シンボリックリンク、環境変数参照形式）
- **ホスト固有設定**: `mcp-servers-TENのノートブックコンピュータ.json`（絶対パス指定）
- 詳細は `docs/workspace/ENVIRONMENT_STRUCTURE.md` の「MCP設定ファイルの運用方針」を参照。

## 参照ドキュメント
- `docs/guides/AGENTS.md`：コントリビュータガイドと運用規約。
- `docs/workspace/ENVIRONMENT_STRUCTURE.md`：環境構成と必須環境変数。
- `docs/reports/`：OneDrive関連の調査記録・手順書。
- `/Users/tennigo/dev/plan.plan.md`：再編成計画とログ。
- `/Users/tennigo/dev/README.md`：`dev/projects` の配置ルール。

## リポジトリマップ（高速参照）
- ルート: 設定と最小リンクのみ。重い成果物は置かない。
- docs/: ガイド・環境構成・レポート  
  - guides/AGENTS.md（運用ガイド）、workspace/ENVIRONMENT_STRUCTURE.md（レイアウトと環境変数）、reports/（命名規則: `YYYYMMDD_テーマ.md`）
- archives/: バックアップや大容量の退避
- shell/: プロンプト設定（例: starship.toml）
- projects -> /Users/tennigo/dev/projects: コード系リポジトリ群（依存インストール・実行はここで）
- knowledge-vault/（サブモジュール）: 個人ナレッジ
- research-vault/（サブモジュール）: 研究ノート・論文ドラフト
- mcp-servers.json / package.json / pnpm-lock.yaml / pyproject.toml / uv.lock: `/Users/tennigo/dev/` へのシンボリックリンク

## 検索の推奨運用（範囲を絞って高速に）
- まず範囲を決める: docs/ or reports/ など対象ディレクトリを限定。
- ファイル名で絞る → 中身を検索:  
  - `rg --files -g "2025*.md" docs/reports` → 対象確認  
  - `rg "OneDrive" docs/reports`
- サブモジュールの扱い: 平常時は除外（大規模）だが、必要なときはディレクトリを明示して絞る。  
  - 例: `rg "暗号資産" knowledge-vault/03\ Daily/202502*`  
  - 除外例: `rg "OneDrive" . --glob "!knowledge-vault/**" --glob "!research-vault/**"`
- 研究テーマ関連の検索依頼をエージェントに行う場合は、`research-vault/` 配下（例: `03_thesis_draft/` や `02_literature_review/`）を明示して範囲指定する。通常の検索では両サブモジュールを除外する。
- よく見る起点:  
  - 環境変数とレイアウト: `docs/workspace/ENVIRONMENT_STRUCTURE.md`  
  - 運用ガイド: `docs/guides/AGENTS.md`  
  - OneDrive関連: `docs/reports/2025*.md`
