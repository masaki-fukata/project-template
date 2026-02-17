# docs - プロジェクトドキュメント構成ガイド

プロジェクト共通のドキュメント構造です。各アプリでコピーまたは参照して利用してください。

---

## 全体構成

```
project-template/
├── .cursor/                    Cursor AI 設定
│   ├── prompts/                  共通プロンプト
│   └── rules/                    共通ルール + ドキュメント参照ワークフロー
├── .cursorrules                Cursor AI コーディング規約（全ツール共通）
├── .env.example                環境変数テンプレート
├── .gitignore                  Git 除外設定
├── CLAUDE.md                   Claude Code 用プロジェクト指示・ワークフロー
├── README.md                   プロジェクト概要・セットアップ手順
├── docs/                       ドキュメント一式（下記参照）
├── setup-cursor-hybrid.sh      Cursor ハイブリッドセットアップ
├── sync-targets.txt            同期対象プロジェクト一覧
└── sync-template-to-projects.sh  テンプレート同期スクリプト
```

---

## docs/ フォルダ構成

```
docs/
├── 00_process/        【共通】開発の型
│   ├── RULES.md             開発ルール・AI への指示
│   ├── WORKFLOW.md          開発フェーズと手順
│   ├── PROMPTS.md           各工程で使うプロンプト集
│   └── DEFINITION_OF_DONE.md  完了の定義
│
├── 01_concept/        【固有】アプリの中身
│   ├── SPEC.md              要件定義・機能一覧・MVP スコープ
│   ├── ARCH.md              システム構成・DB/API 設計
│   ├── TECH_STACK.md        技術選定・バージョン管理
│   └── UI_UX.md             画面遷移・デザインコンセプト
│
├── 02_management/     【固有】進行管理
│   ├── PROGRESS.md          ロードマップ・タスク進捗
│   └── LOGS/                日々の作業ログ
│       └── yyyy-mm-dd.md
│
├── 03_review/         【固有】レビュー・振り返り
│   ├── REVIEW_CHECKLIST.md  コードレビューチェックリスト
│   └── RETROSPECTIVE.md    振り返り（KPT形式）
│
└── 99_artifacts/      【固有】成果物・メモ
    ├── assets/              画像・デザインファイル等
    ├── research/            調査メモ・参考資料
    └── templates/           Issue/PR テンプレート、AI コンテキスト
        ├── CONTEXT_FOR_AI.md
        ├── ISSUE_TEMPLATE.md
        └── PR_TEMPLATE.md
```

---

## 各フォルダの詳細

### 00_process/ — 開発の型（共通）

プロジェクト横断で共通のルール・手順を定義します。テンプレートから変更する必要がないことが多いフォルダです。

| ファイル | 役割 | いつ使うか |
|----------|------|-----------|
| **RULES.md** | AI の権限・運用ルール（コーディング規約は `.cursorrules`） | 常時（AI が参照） |
| **WORKFLOW.md** | 開発フェーズの定義、各工程の入力/出力 | プロジェクト開始時・フェーズ移行時 |
| **PROMPTS.md** | 各工程で AI に投げるプロンプト集 | 各フェーズの作業時 |
| **DEFINITION_OF_DONE.md** | タスク・フェーズ・リリースの完了基準 | タスク完了判断時 |

### 01_concept/ — アプリの中身（固有）

プロジェクトごとに内容が異なる設計ドキュメントです。フェーズ1〜2で集中的に作成します。

| ファイル | 役割 | いつ使うか |
|----------|------|-----------|
| **SPEC.md** | 要件定義、ターゲットユーザー、MVP スコープ、用語集 | フェーズ1（企画・要件定義） |
| **ARCH.md** | システム構成、DB/API 設計、ディレクトリ構成、環境変数 | フェーズ2（設計） |
| **TECH_STACK.md** | 技術選定の一覧と選定理由 | フェーズ2（設計） |
| **UI_UX.md** | 画面遷移、デザインコンセプト、ワイヤーフレーム | フェーズ1〜2 |

### 02_management/ — 進行管理（固有）

進捗トラッキングと作業記録を行います。

| ファイル | 役割 | いつ使うか |
|----------|------|-----------|
| **PROGRESS.md** | ロードマップ、フェーズごとのチェックリスト | 毎日（AI が作業前に確認） |
| **LOGS/yyyy-mm-dd.md** | 日々の作業内容・判断・次回 TODO | 毎日（作業終了時に記録） |

### 03_review/ — レビュー・振り返り（固有）

品質担保と改善サイクルのためのドキュメントです。

| ファイル | 役割 | いつ使うか |
|----------|------|-----------|
| **REVIEW_CHECKLIST.md** | PR・コードレビューの確認項目 | コードレビュー時 |
| **RETROSPECTIVE.md** | KPT 形式の振り返り記録 | フェーズ完了時・リリース後 |

### 99_artifacts/ — 成果物・メモ（固有）

設計資料や調査結果など、分類しにくいファイルの置き場所です。

| フォルダ | 用途 |
|----------|------|
| **assets/** | 画像、デザインファイル、スクリーンショット |
| **research/** | 技術調査メモ、競合分析、参考リンク集 |
| **templates/** | Issue / PR テンプレート、Antigravity 向け AI コンテキスト |

---

## 開発フローとドキュメントの対応

```
フェーズ1 企画     → SPEC.md, UI_UX.md を作成
    ↓
フェーズ2 設計     → ARCH.md, TECH_STACK.md を作成
    ↓
フェーズ3 実装     → PROGRESS.md を更新、LOGS/ に記録
    ↓
フェーズ4 品質向上 → REVIEW_CHECKLIST.md でレビュー
    ↓
フェーズ5 公開     → RETROSPECTIVE.md で振り返り
```

各フェーズの詳細は `00_process/WORKFLOW.md` を参照してください。

---

## AI ツール別の参照ファイル

各ツールが自動で読み込むファイルと、手動で渡すファイルの対応表です。

| ツール | 自動読み込み | 手動で参照させる |
|--------|-------------|-----------------|
| **Cursor** | `.cursorrules`, `.cursor/rules/*.md`, `.cursor/prompts/*.md` | `docs/` 内は `rules/doc-workflow.md` の指示に従い AI が自主的に読む |
| **Claude Code** | `CLAUDE.md` | `CLAUDE.md` 内のルーティンに従い AI が自主的に `docs/` を読む |
| **Antigravity** | プロジェクト指示として設定 | `docs/99_artifacts/templates/CONTEXT_FOR_AI.md` を埋めて渡す |
