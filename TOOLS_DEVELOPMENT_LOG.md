# ツール開発記録 (Obsidian)

## 📋 概要
このファイルは、zotero-scriptsプロジェクトのツール開発状況をObsidianで管理するための記録です。

## 🔗 相互参照
- **zotero-scripts**: `/Users/tennigo/zotero-scripts/INSTALLATION_LOG.md`
- **このファイル**: `/Users/tennigo/Library/Mobile Documents/com~apple~CloudDocs/obsidian/external_brain2/TOOLS_DEVELOPMENT_LOG.md`

## 📊 開発状況ダッシュボード

### 🟢 完了済みツール
| ツール名 | カテゴリ | 完了日 | バージョン | 状態 |
|---------|---------|--------|-----------|------|
| PDF圧縮ツール | PDF処理 | 2025-01-XX | 1.0.0 | 本番稼働 |
| PDF OCR CLI | OCR処理 | 2025-01-XX | 1.0.0 | 本番稼働 |
| バッチOCR・ノート生成 | Zotero連携 | 2025-06-XX | 1.0.0 | 本番稼働 |
| 単一アイテムOCR・ノート生成 | Zotero連携 | 2025-06-XX | 1.0.0 | 本番稼働 |
| BibTeX生成ツール | Zotero連携 | 2025-06-XX | 1.0.0 | 本番稼働 |
| Zotero-Markdown同期 | Zotero連携 | 2025-06-XX | 1.0.0 | 本番稼働 |
| PDFテキスト抽出ツール | テキスト抽出 | 2025-06-XX | 1.0.0 | 本番稼働 |
| サーチャブルPDF回転ツール | PDF処理 | 2025-06-XX | 1.0.0 | 本番稼働 |
| 環境チェックツール | メンテナンス | 2025-06-XX | 1.0.0 | 本番稼働 |
| textlint-ai-writing | 文章品質管理 | 2025-07-13 | 1.0.0 | 本番稼働 |
| 文献データベース管理ツール | 文献検索・管理 | 2025-07-15 | 1.0.0 | 本番稼働 |

### 🟡 開発中ツール
| ツール名 | カテゴリ | 開始日 | 進捗 | 次回更新予定 |
|---------|---------|--------|------|-------------|
| Zotero OCR処理ツール | Zotero連携・OCR | 2025-07-15 | 90% | 統合テスト中 |
| Zotero PDF処理ツール | Zotero連携・PDF | 2025-07-15 | 85% | 機能拡張中 |

### 🔴 計画中ツール
| ツール名 | カテゴリ | 計画日 | 優先度 | 概要 |
|---------|---------|--------|--------|------|
| Obsidian MCP サーバー | MCP連携 | 2025-07-XX | 中 | Obsidian操作API |
| Zotero MCP サーバー | MCP連携 | 2025-07-XX | 中 | Zotero操作API |

## 📝 詳細開発記録

### 2025-07-15: 文献データベース管理ツール 本番稼働

#### 開発目的
- 高速文献検索システムの構築
- 法学論文執筆における参考文献アクセス向上
- Zotero連携による効率的な研究環境

#### 主要機能
- **高速検索**: キーワード、著者、年度による検索
- **言語フィルタリング**: 日本語・外国語文献の分別
- **インタラクティブモード**: 対話型検索インターフェース
- **データベース統計**: 文献数、カテゴリ別集計
- **リアルタイム監視**: 新規ファイル自動検出

#### 技術仕様
- **データベース**: SQLite3
- **全文検索**: FTS5 (Full-Text Search)
- **ファイル監視**: watchdog
- **設定管理**: JSON設定ファイル
- **場所**: `/Users/tennigo/zotero-scripts/tools/literature-database-manager/`

#### 使用例
```bash
cd /Users/tennigo/zotero-scripts
# キーワード検索
uv run python tools/literature-database-manager/src/literature_search.py --keyword "暗号資産"
# 著者検索
uv run python tools/literature-database-manager/src/literature_search.py --author "中里実"
# 統計情報
uv run python tools/literature-database-manager/src/literature_database.py --stats
```

#### 統合ポイント
- **論文執筆**: Claude Code での文献検索フロー統合
- **Obsidian**: 外部参照リンク管理
- **Zotero**: メタデータ同期

---

### 2025-07-13: textlint-ai-writing 開発完了

#### 開発目的
- AI生成テキストの不自然な表現を検出
- 法学論文の品質向上
- Cursor IDEとの統合

#### 開発成果
- ✅ npmプロジェクトのセットアップ
- ✅ textlint-rule-preset-ai-writingの統合
- ✅ 設定ファイルの作成
- ✅ Cursor IDE統合用スクリプト
- ✅ Git Hooks設定
- ✅ 論文プロジェクト統合スクリプト

#### 技術仕様
- **Node.js**: v18.x以上
- **textlint**: v15.2.0
- **textlint-rule-preset-ai-writing**: v1.1.0
- **対応ファイル**: .md, .qmd, .txt

#### 検出機能
1. 絵文字の使用（リストアイテム）
2. 誇張表現（「革命的」「ゲームチェンジャー」）
3. 抽象的表現（「魔法のように」「奇跡的な」）
4. 権威的表現（「未来を変える」「パラダイムシフト」）

#### 統合機能
- **Cursor IDE**: リアルタイムチェック
- **Git Hooks**: コミット前自動チェック
- **論文プロジェクト**: 統合スクリプト

#### 今後の改善点
- [ ] Cursor IDEでの動作確認
- [ ] 論文プロジェクトでの実際の使用
- [ ] カスタムルールの追加
- [ ] パフォーマンス最適化

---

## 🔧 開発環境

### 主要技術スタック
- **Python**: 3.11+ (メイン開発言語)
- **Node.js**: v18.x+ (textlint用)
- **uv**: Python依存関係管理
- **npm**: Node.js依存関係管理
- **SQLite3**: 文献データベース
- **FTS5**: 全文検索エンジン

### 外部ツール
- **Ghostscript**: PDF圧縮
- **YomiToku**: OCR処理
- **Zotero**: 文献管理
- **textlint**: 文章品質チェック
- **watchdog**: ファイル監視
- **PyMuPDF**: PDF操作
- **tkinter**: GUIインターフェース

## 📁 プロジェクト構造

```
zotero-scripts/
├── INSTALLATION_LOG.md          # インストールログ
├── TOOLS_REGISTRY.json          # ツール登録情報（11ツール）
├── CLAUDE.md                    # Claude向けガイダンス
├── tools/                       # ツールコレクション（7ツール）
│   ├── literature-database-manager/ # 🆕 文献データベース管理
│   ├── textlint-ai-writing/     # 文章品質管理ツール
│   ├── pdf-ocr-cli/            # PDF OCR処理
│   ├── pdf-text-extractor/     # PDFテキスト抽出
│   ├── zotero-markdown-note-sync/ # Zotero-Markdown同期
│   ├── zotero-ocr-processor/   # Zotero OCR処理
│   └── zotero-pdf-processor/   # Zotero PDF処理
├── scripts/                     # 実行スクリプト（20+スクリプト）
│   ├── batch_ocr_and_notes.py  # バッチOCR・ノート生成
│   ├── single_item_ocr_note.py # 単一アイテムOCR
│   ├── create_bibtex.py        # BibTeX生成
│   ├── check_setup.py          # 環境チェック
│   ├── compress_pdf.py         # PDF圧縮
│   ├── rotate_searchable_pdfs.py # PDF回転
│   └── obsidian_mcp_server.py  # Obsidian MCP サーバー
├── config/                      # 設定ファイル
├── logs/                        # ログファイル
├── data/                        # データファイル
├── temp_results/               # 一時結果
└── test_results/               # テスト結果
```

## 🔄 更新履歴

### 2025-07-15
- 文献データベース管理ツールの本番稼働開始
- 高速文献検索システムの統合
- Claude Code ワークフローの最適化
- TOOLS_DEVELOPMENT_LOG.md の大幅更新

### 2025-07-13
- textlint-ai-writingツールの開発完了
- インストールログ管理システムの構築
- 相互参照システムの設計
- TOOLS_REGISTRY.jsonの更新

## 📞 連絡先・参照先
- **プロジェクト**: zotero-scripts
- **Obsidian**: external_brain2
- **更新頻度**: ツール追加・更新時
- **最終更新**: 2025-07-15

## 🏷️ タグ
#zotero-scripts #tool-development #textlint #ai-writing #literature-database #installation-log #development-record #文献検索 #academic-research 