# プロジェクト進捗管理表

## 🛠 AIへの絶対指示（システム命令）
1. 作業を開始する前に、必ずこのファイルを確認し、現在のフェーズを把握すること。
2. タスクを完了したら、該当項目の [ ] を [x] に書き換えること。
3. 完了時、一番下の「更新ログ」に実施内容と日付を追記すること。
4. 詰まった点や保留事項があれば「メモ」欄に記載すること。

---

## 🚀 ロードマップ

### 【フェーズ1】企画・要件定義 (Main: Claude)
- [ ] 1.1 アイディアの言語化・機能の絞り込み (MVP定義)
  - 成果物: `docs/01_concept/SPEC.md`
- [ ] 1.2 画面遷移図/UIラフの作成 (Artifacts活用)
  - 成果物: `docs/01_concept/UI_UX.md`
- [ ] 1.3 ユーザー定義・ターゲット設定
  - 成果物: `docs/01_concept/SPEC.md`

### 【フェーズ2】設計 (Main: Gemini/Google AI Pro)
- [ ] 2.1 データベース設計 (Supabase用ER図・SQL)
  - 成果物: `docs/01_concept/ARCH.md`（DB設計セクション）
- [ ] 2.2 システムアーキテクチャ図の作成
  - 成果物: `docs/01_concept/ARCH.md`
- [ ] 2.3 API仕様書・エンドポイント定義 (FastAPI)
  - 成果物: `docs/01_concept/ARCH.md`（API設計セクション）
- [ ] 2.4 コーディング規約の策定
  - 成果物: `.cursorrules`、`docs/01_concept/TECH_STACK.md`

### 【フェーズ3】実装：自動生成 (Main: Antigravity)
- [ ] 3.1 プロジェクト環境構築 (Flutter/FastAPI)
  - 成果物: `package.json`、設定ファイル一式、`.env.example`
- [ ] 3.2 認証機能の実装 (Supabase Auth)
  - 成果物: `src/app/api/auth/`
- [ ] 3.3 メイン機能の実装 (AIによる自律実装)
  - 成果物: `src/`
- [ ] 3.4 ユニットテストの作成・実行
  - 成果物: `src/**/*.test.ts`

### 【フェーズ4】調整・品質向上 (Main: Cursor)
- [ ] 4.1 UI/UXデザインのリファイン
  - 成果物: `src/components/`
- [ ] 4.2 リファクタリング・パフォーマンス最適化
  - 成果物: `src/`
- [ ] 4.3 結合テスト・手動デバッグ
  - 成果物: —

### 【フェーズ5】公開・運用 (Main: Gemini/Antigravity)
- [ ] 5.1 インフラ構築 (Google Cloud Run等)
  - 成果物: インフラ設定ファイル一式
- [ ] 5.2 CI/CDパイプライン設定 (GitHub Actions)
  - 成果物: `.github/workflows/`
- [ ] 5.3 ドキュメント作成・リリース準備
  - 成果物: `docs/`、`README.md`

---

## 📝 メモ・保留事項
- (ここにAIが現在の課題やあなたへの質問を記載します)

---

## 🕒 更新ログ
- yyyy-mm-dd: ファイル作成 (ユーザー)