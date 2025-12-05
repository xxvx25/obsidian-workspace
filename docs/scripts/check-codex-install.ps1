# Codex CLI インストール確認スクリプト
# 使用方法: .\check-codex-install.ps1

Write-Host "=== Codex CLI インストール確認 ===" -ForegroundColor Cyan
Write-Host ""

# 1. npmのグローバルパス確認
Write-Host "1. npmグローバルパスの確認" -ForegroundColor Yellow
$npmGlobalPath = npm root -g 2>&1 | Out-String
$npmBinPath = npm bin -g 2>&1 | Out-String
$npmGlobalPath = $npmGlobalPath.Trim()
$npmBinPath = $npmBinPath.Trim()
Write-Host "   npm root -g: $npmGlobalPath"
Write-Host "   npm bin -g: $npmBinPath"
Write-Host ""

# 2. パッケージの存在確認
Write-Host "2. @openai/codex パッケージの確認" -ForegroundColor Yellow
$packagePath = Join-Path $npmGlobalPath "@openai\codex"
if (Test-Path $packagePath) {
    Write-Host "   ✓ パッケージが見つかりました: $packagePath" -ForegroundColor Green
} else {
    Write-Host "   ✗ パッケージが見つかりません: $packagePath" -ForegroundColor Red
}
Write-Host ""

# 3. codexコマンドの確認
Write-Host "3. codexコマンドの確認" -ForegroundColor Yellow
$codexCmd = Get-Command codex -ErrorAction SilentlyContinue
if ($codexCmd) {
    Write-Host "   ✓ codexコマンドが見つかりました: $($codexCmd.Source)" -ForegroundColor Green
    Write-Host "   バージョン確認:"
    codex --version 2>&1
} else {
    Write-Host "   ✗ codexコマンドが見つかりません" -ForegroundColor Red
    Write-Host ""
    Write-Host "   npm bin -g のパスが環境変数PATHに含まれているか確認してください" -ForegroundColor Yellow
    Write-Host "   現在のPATH:"
    $env:PATH -split ';' | Where-Object { $_ -like "*node*" -or $_ -like "*npm*" } | ForEach-Object { Write-Host "     $_" }
}
Write-Host ""

# 4. インストール状況の確認
Write-Host "4. npmグローバルパッケージ一覧" -ForegroundColor Yellow
$installed = npm list -g @openai/codex --depth=0 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✓ @openai/codex がインストールされています" -ForegroundColor Green
    $installed
} else {
    Write-Host "   ✗ @openai/codex がインストールされていません" -ForegroundColor Red
    Write-Host ""
    Write-Host "   インストールコマンド:" -ForegroundColor Yellow
    Write-Host "   npm install -g @openai/codex@latest" -ForegroundColor Cyan
}
Write-Host ""

# 5. 推奨される対処法
Write-Host "=== 推奨される対処法 ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. インストール実行:" -ForegroundColor Yellow
Write-Host "   npm install -g @openai/codex@latest" -ForegroundColor Cyan
Write-Host "   注意: v0.22.0以降でWindowsサポートが改善されています" -ForegroundColor Gray
Write-Host ""
Write-Host "2. PATHにnpm bin -gのパスが含まれているか確認:" -ForegroundColor Yellow
Write-Host "   npm bin -g の出力パスが環境変数PATHに含まれている必要があります" -ForegroundColor White
Write-Host "   一時的に追加する場合:" -ForegroundColor Gray
Write-Host "   `$npmBin = npm bin -g; `$env:PATH = \"`$npmBin;`$env:PATH\"" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. バージョン確認:" -ForegroundColor Yellow
Write-Host "   codex --version" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Cursorを再起動して環境変数を再読み込み" -ForegroundColor Yellow
Write-Host ""
Write-Host "5. 初回起動:" -ForegroundColor Yellow
Write-Host "   codex" -ForegroundColor Cyan
Write-Host "   → ChatGPTアカウントでサインインするか、APIキーを設定" -ForegroundColor Gray
Write-Host ""
