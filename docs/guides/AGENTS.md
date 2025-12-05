# リポジトリガイドライン

## プロジェクト構造とモジュール構成
- ルートはワークスペース設定と最小限のリンクのみを保持します。ドキュメントは `docs/`（ガイド・環境構成・調査レポート）、アーカイブは `archives/` に集約します。
- コンテンツボルト `knowledge-vault/` と `research-vault/` は別リポジトリ（ここでは無視）。ボルト内のノートはこのリポジトリでコミットしないでください。
- `projects/` は `/Users/tennigo/dev/projects` へのシンボリックリンクで、コード変更・依存インストール・実行はそちらの各リポジトリで行います。
- 主要ファイル: `docs/workspace/ENVIRONMENT_STRUCTURE.md`（レイアウト/環境変数）、`shell/starship.toml`（プロンプト設定）、シンボリックリンクされた依存マニフェスト（`package.json`、`pnpm-lock.yaml`、`pyproject.toml`、`uv.lock`）。重い成果物（`node_modules/`、`.venv/`、`logs/`）は追跡しません。

## ビルド、テスト、開発コマンド
- Node/Quartoタスク（PNPMでルートから実行）: `pnpm lint`（`paper(dr)/03_thesis_draft/*.qmd` のtextlint）、`pnpm lint:fix`（自動修正）、`pnpm run check:footnotes`（脚注チェック）、`pnpm run check:quality`（lint+脚注チェックをまとめて実行）、`pnpm preview`（Quartoプレビュー）、`pnpm pdf`（lint+脚注チェック後にPDF生成）。
- Pythonツールは `uv` を利用: `uv sync` で依存をインストール；`uv run black .` / `uv run isort .` / `uv run mypy <path>` でフォーマット・型チェック；`uv run pytest` でテスト。これらは `projects/` 配下の該当プロジェクトで実行してください。

## コーディングスタイルと命名規則
- Python: Black（88桁、4スペース）、isortでインポート整列、mypy前提の型ヒント。モジュール/関数はsnake_case、クラスはPascalCase。
- テキスト/Quarto: 見出しはセンテンスケース、簡潔な箇条書きを基本とし、コミット前にtextlintを実行。
- ファイル名: スクリプト/設定はkebab-caseを推奨。ロケール固有文字は既存資産を除き避ける。

## ドキュメント運用
- 調査記録や運用手順は `docs/reports/` にまとめ、日付やテーマでファイル名を揃える。構成メモは `docs/workspace/`、ガイドは `docs/guides/` に置く。
- バックアップや一時保管物は `archives/` に移し、タイムスタンプを含めたファイル名にする。大容量ファイルをルートに置かない。
- 新しいトップレベルフォルダやシンボリックリンクを追加した場合は、`README.md` のツリーとこのガイドを更新する。

## テストガイドライン
- 変更箇所近くの `tests/` にpytestケースを追加し、`test_*.py` 形式で決定論的なアサーションを心掛ける。カバレッジ維持/向上と回帰テスト追加を目指す。
- `paper(dr)/03_thesis_draft` を編集する場合、`pnpm lint`（安全なら `pnpm lint:fix`）と `pnpm run check:footnotes` を実行。レンダリング確認は `pnpm preview` の上で必要に応じ `pnpm pdf`。

## コミットとプルリクエストガイドライン
- Git履歴は慣例的なプレフィックス（例: `chore: update env paths`）を使用。短い命令形メッセージ（例: `feat: add zotero sync helper`、`fix: guard empty citation list`）を徹底。
- PRではスコープ（ルート設定 vs 特定プロジェクト）を明記し、主な変更点と実行テストコマンドを列挙。関連課題リンクと必要な環境変数（`EXTERNAL_BRAIN_ROOT`、`ZOTERO_SCRIPTS_ROOT`、`OCR_OUTPUT_DIR`）を記載。生成物やボルトコンテンツのコミットは禁止。

## セキュリティと設定のヒント
- インストール/ビルド/実行は `/Users/tennigo/dev/projects/**` で行い、クラウド同期対象から切り離す。シークレットはローカル環境変数や `zotero.env` に保持し、認証情報・トークンをコミットしない。
- レポート類は `docs/reports/`、バックアップ等の大きなファイルは `archives/` に置き、ルートは軽量な設定のみを保持する。

## エージェント運用
- コーデックス（エージェント）は原則として日本語で思考し、日本語で出力する。ユーザーから明示的に指示がある場合のみ例外とする。
- ドキュメントやコメントを追加する際も日本語を優先し、必要に応じて英語併記を最小限で行う。

## 作業の流れ（クイックガイド）
1. ルートの変更が必要か確認し、ドキュメントは `docs/`、アーカイブは `archives/` へ配置する。
2. コードや依存の変更は `projects/` 配下の対象リポジトリで実施し、必要に応じて `uv sync` や `pnpm install` を各リポジトリ側で行う。
3. 変更したコンテンツに応じて `pnpm run check:quality` または `uv run pytest` などを実行し、結果をPRに記載する。
4. PRでは影響範囲・設定変更・テスト結果を簡潔にまとめ、関連ドキュメント（例: `docs/workspace/ENVIRONMENT_STRUCTURE.md`）を更新した場合はリンクを添える。
