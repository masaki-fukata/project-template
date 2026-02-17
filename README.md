# project-template

Cursor のルール（`.cursorrules`）やプロンプト（`.cursor/prompts/`）など、プロジェクト共通の設定をまとめたテンプレートです。

## テンプレートの .cursor 内の役割

| 場所 | 役割 |
|------|------|
| `.cursor/rules/` | 共通ルール（.md / .mdc）。各プロジェクトでは `.cursor/rules/template` としてシンボリックリンクされる想定。 |
| `.cursor/prompts/` | 共通プロンプト（.md）。各プロジェクトでは `.cursor/prompts/template` としてシンボリックリンクされる想定。 |

## 各プロジェクトで最新を取り込む方法

### 方法1: 同期スクリプトを使う（推奨）

テンプレートを更新したあと、各プロジェクトに反映したいときに以下を実行します。

```bash
# project ディレクトリで実行
./project-template/sync-template-to-projects.sh
```

初回のみ実行権限を付与してください。

```bash
chmod +x project-template/sync-template-to-projects.sh
```

スクリプトは `sync-targets.txt` に書かれたプロジェクトパスへ、テンプレートのファイルを**上書きコピー**します。プロジェクト側で変更した内容は上書きされるので、必要ならバックアップや差分確認をしてから実行してください。

---

### 方法2: シンボリックリンクで「常に同じ内容」にする

テンプレートを「参照」だけして、実体は1箇所に置く方法です。テンプレートを更新すると、リンクを張った全プロジェクトで即時に同じ内容になります。

- **メリット**: 更新が1回で全プロジェクトに反映される
- **デメリット**: プロジェクトごとに .cursorrules などを変えられない（上書きするとリンクが実ファイルに変わる場合あり）

各プロジェクトのルートで例として以下を実行（パスは環境に合わせて変更）:

```bash
# 例: 100days-apps でテンプレートを参照する場合
cd /Users/fukatamasaki/project/100days-apps
rm -f .cursorrules
ln -s ../project-template/.cursorrules .cursorrules
rm -rf .cursor
ln -s ../project-template/.cursor .cursor
```

---

### 方法2': .cursor 内で「テンプレート」と「プロジェクト固有」を分ける（ハイブリッド）

**.cursor** の中だけテンプレートをシンボリックリンクにし、それ以外はプロジェクト固有のフォルダとして持つ方法です。

- **テンプレート側（シンボリックリンク）**: 共通ルール・共通プロンプト → テンプレートを更新すると全プロジェクトに即反映
- **プロジェクト固有**: そのプロジェクトだけのルール・プロンプト → 実ファイルで保持

#### 想定する .cursor の構成

```
.cursor/
├── rules/
│   ├── template/          ← シンボリックリンク（project-template の .cursor/rules を参照）
│   └── *.mdc または *.md  ← プロジェクト固有のルール（ここに直置き）
└── prompts/
    ├── template/          ← シンボリックリンク（project-template の .cursor/prompts を参照）
    └── *.md               ← プロジェクト固有のプロンプト（ここに直置き）
```

Cursor は `.cursor/rules/` のサブディレクトリも読み込むため、`rules/template/` はそのまま共通ルールとして認識されます。プロンプトも同様に `prompts/template/` 内が参照されます。

#### セットアップ方法

プロジェクトのルートで、次のいずれかで実行します。

```bash
# パターンA: 対象プロジェクトのルートに cd してから実行
cd /Users/fukatamasaki/project/100days-apps
/path/to/project-template/setup-cursor-hybrid.sh

# パターンB: project ルートからプロジェクト名を引数で渡す
cd /Users/fukatamasaki/project
./project-template/setup-cursor-hybrid.sh 100days-apps
```

初回のみ実行権限を付与してください。

```bash
chmod +x project-template/setup-cursor-hybrid.sh
```

- 既に `.cursor/rules/template` や `.cursor/prompts/template` がある場合は上書きしません。
- ルートの `.cursorrules` は触りません。テンプレートのものをコピーして使うか、プロジェクト用に編集したファイルをそのまま使ってください。

---

### 方法3: Git のサブモジュール / サブツリー

- **サブモジュール**: `project-template` を別リポジトリにし、各プロジェクトで `git submodule add` で取り込む。更新は `git submodule update --remote` で取得し、必要ならコピーやマージで `.cursorrules` 等に反映する。
- **サブツリー**: テンプレートを各リポジトリの一部としてマージし、`git subtree pull` でテンプレートの更新を取り込む。

いずれも Git の知識が必要で、既存プロジェクトへの組み込みは少し手間になります。

---

## 運用の目安

- **テンプレートをよく更新し、全プロジェクトで同じルールにしたい** → 方法1（同期スクリプト）か方法2（シンボリックリンク）
- **プロジェクトごとにルールを少し変えたい** → 方法1で「必要なときだけ」同期し、変更したプロジェクトは `sync-targets.txt` から外すか、同期後に手で直す

同期対象のプロジェクト一覧は `sync-targets.txt` で管理します。
