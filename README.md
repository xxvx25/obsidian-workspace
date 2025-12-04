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
├── knowledge-vault/          # 外部ボルト（別リポジトリ、ルートからは無視）
├── research-vault/           # リサーチボルト（別リポジトリ、ルートからは無視）
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

## 参照ドキュメント
- `docs/guides/AGENTS.md`：コントリビュータガイドと運用規約。
- `docs/workspace/ENVIRONMENT_STRUCTURE.md`：環境構成と必須環境変数。
- `docs/reports/`：OneDrive関連の調査記録・手順書。
- `/Users/tennigo/dev/plan.plan.md`：再編成計画とログ。
- `/Users/tennigo/dev/README.md`：`dev/projects` の配置ルール。
