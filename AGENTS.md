# Repository Guidelines

## プロジェクト構成とモジュール配置
- ルートはワークスペース設定とシンボリックリンクのみを保持します。docs/ にガイド・ワークスペースメモ・レポート、archives/ にバックアップ、shell/ にプロンプト設定を置きます。
- knowledge-vault/ と research-vault/ は別リポジトリのボルトです。この履歴では触れず、コミット対象から外します。
- projects/ は /Users/tennigo/dev/projects へのシンボリックリンクです。依存インストール・ビルド・コード変更は必ず各プロジェクトリポジトリ側で行ってください。

## ビルド・テスト・開発コマンド
- コマンドは対象プロジェクト配下 (projects/<repo>/) で実行します。
- Node/Quarto（例: paper(dr)/03_thesis_draft）: pnpm lint (textlint)、pnpm lint:fix (自動修正)、pnpm run check:footnotes (脚注整合性)、pnpm run check:quality (lint+脚注)、pnpm preview (Quartoプレビュー)、pnpm pdf (lint+脚注後PDF生成)。
- Python: uv sync で依存導入、uv run black . / uv run isort . で整形、uv run mypy <path> で型チェック、uv run pytest でテスト。

## コーディングスタイルと命名
- Python: Black (88桁)、isort、mypy前提の型ヒント。関数/モジュールは snake_case、クラスは PascalCase、インポートは整列を維持。
- Text/Quarto: 見出しはセンテンスケース、簡潔な段落を維持し、コミット前に textlint を実行。
- ファイル/スクリプトは kebab-case 推奨。ロケール固有文字は既存箇所以外で避けます。

## テスト指針
- 変更近くの tests/ に test_*.py 形式で追加し、回帰テストを優先。アサーションは決定論的に。
- 実行は uv run pytest。skip/xfail は理由をコメントし、カバレッジが後退しないようにします。

## コミットとプルリクエスト
- コミットメッセージは feat: fix: chore: docs: refactor: などの簡潔な命令形プレフィックスを踏襲。
- 生成物や node_modules/ .venv/ dist/ 大容量ログはコミットしません。ドキュメントは docs/、バックアップは archives/ に置きます。
- PR ではスコープ（ルート設定か projects/<repo> か）、主要変更点、実行コマンド、関連 Issue、触れた環境変数（例: EXTERNAL_BRAIN_ROOT, ZOTERO_SCRIPTS_ROOT, OCR_OUTPUT_DIR）を記載。UI/ドキュメント更新は必要に応じてスクリーンショットを添付。

## セキュリティと構成
- 秘密情報はローカル env ファイル（例: zotero.env）に保持し、トークンやキーを Git に含めません。
- ルートの軽量性を維持し、新しいトップレベルリンクを追加する場合は README や関連ドキュメントを更新します。

## エージェント出力と言語ルール
- 試行過程やユーザーへの説明は必ず日本語で記述します。周辺ファイルの言語に合わせ、日本語を優先してください。
- 英語が必要な場合も最小限とし、指示があればそれに従います。
