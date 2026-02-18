# CLAUDE.md

Claude Code がこのプロジェクトで従うべき指示です。

## Dev Container での開発（推奨）

このプロジェクトは **Dev Container** 内での開発を推奨します。
コンテナ内では Claude Code が事前インストールされ、自律エージェントが利用できます。

### 起動方法
1. VS Code / Cursor で「Reopen in Container」を選択
2. `ANTHROPIC_API_KEY` をホスト環境変数に設定しておく
   ```bash
   export ANTHROPIC_API_KEY=your-key
   ```

### 自律エージェントの実行（Dangerous Mode）
コンテナ内では確認プロンプトをスキップした完全自律モードで動作します。

```bash
# 直接タスクを渡す
./scripts/agent.sh "SPEC.md を読んで認証機能を実装してください"

# タスクファイルを渡す
./scripts/agent.sh -f docs/tasks/implement-auth.md

# 直接 claude コマンドで実行
claude --dangerously-skip-permissions -p "タスク内容"
```

> **注意**: `--dangerously-skip-permissions` は全ツールを確認なしで実行します。
> dev container の分離環境内での使用を前提としています。

### 権限設定
`.claude/settings.json` にプロジェクトレベルの広範な権限が設定済みです。
ローカル開発で権限を絞る場合は `.claude/settings.local.json`（gitignore済み）で上書きしてください。

---

## プロジェクト概要
このリポジトリは、アプリ開発プロジェクトのテンプレートです。
各プロジェクトにコピーまたはシンボリックリンクして利用します。

## ドキュメント構成
- `docs/00_process/` — 開発の型（RULES / WORKFLOW / PROMPTS / DEFINITION_OF_DONE）
- `docs/01_concept/` — アプリの中身（SPEC / ARCH / TECH_STACK / UI_UX）
- `docs/02_management/` — 進行管理（PROGRESS / LOGS）
- `docs/03_review/` — レビュー・振り返り（REVIEW_CHECKLIST / RETROSPECTIVE）
- `docs/99_artifacts/` — 成果物（assets / research / templates）

## 作業開始時のルーティン
1. `docs/02_management/PROGRESS.md` を読み、現在のフェーズと未完了タスクを把握する
2. `docs/01_concept/SPEC.md` を読み、要件・MVP スコープ・用語を確認する
3. `docs/01_concept/ARCH.md` を読み、技術スタック・ディレクトリ構成・DB/API 設計を確認する
4. 直近の `docs/02_management/LOGS/` を読み、前回の作業内容と次回 TODO を確認する

## フェーズ別の行動指針
### フェーズ1（企画・要件定義）
- 出力先: `SPEC.md`, `UI_UX.md`
- やること: アイデアの言語化、ターゲットユーザー定義、MVP スコープ決定

### フェーズ2（設計）
- 出力先: `ARCH.md`, `TECH_STACK.md`
- やること: 技術選定、システム構成図、DB/API 設計、ディレクトリ構成

### フェーズ3（実装）
- 参照: `SPEC.md`, `ARCH.md` に基づいて実装
- やること: 環境構築、機能実装、テスト作成

### フェーズ4（品質向上）
- 参照: `REVIEW_CHECKLIST.md`, `DEFINITION_OF_DONE.md`
- やること: コードレビュー、リファクタリング、パフォーマンス確認

### フェーズ5（公開）
- やること: デプロイ、CI/CD 設定、ドキュメント最終確認
- 完了後: `RETROSPECTIVE.md` に振り返りを記録

## 作業完了時のルーティン
1. `PROGRESS.md` の該当チェックボックスを更新する
2. `docs/02_management/LOGS/yyyy-mm-dd.md` に実施内容・次回 TODO を記録する
3. 設計変更があった場合、該当する `docs/01_concept/` のファイルを更新する
4. 環境変数を追加した場合、`ARCH.md` と `.env.example` を更新する

## コーディング規約
`.cursorrules` に記載。主要ポイント:
- 命名は直感的かつ5単語以内
- Boolean は `is` / `has` / `should` 接頭辞
- UI とロジックを分離（カスタムフック / Service / ユーティリティ）
- Import は外部→内部の順、アルファベット順

## コミット規約
- Conventional Commits 形式（`feat:`, `fix:`, `refactor:`, `docs:` 等）
- メッセージは簡潔な日本語で記述

## PROGRESS.md の操作ルール
- **チェックボックスの更新（`[ ]` → `[x]`）のみ許可**
- 項目のテキスト変更・削除・追加は**禁止**。必要な場合はユーザーに提案してから承認を得ること

## やってはいけないこと
- `docs/` のドキュメントを読まずに実装を始めること
- 指示が曖昧なまま推測で進めること（質問を優先）
- 同じエラーに対して2回以上同じ修正を試みること（根本原因を分析して報告）
- 破壊的操作（DB マイグレーション、ブランチ削除等）を確認なしに実行すること
- `PROGRESS.md` の項目を勝手に変更・追加・削除すること
