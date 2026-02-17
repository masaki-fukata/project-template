#!/usr/bin/env bash
# プロジェクト内で .cursor を「テンプレート（シンボリックリンク）」と「プロジェクト固有」に分けてセットアップする。
# 使い方: 対象プロジェクトのルートで実行
#   cd /path/to/your-project
#   /path/to/project-template/setup-cursor-hybrid.sh
#
# または project ルートから:
#   ./project-template/setup-cursor-hybrid.sh 100days-apps

set -e

# 実行元がプロジェクトルートか、引数でプロジェクトパスを渡す
if [[ -n "$1" ]]; then
  PROJECT_ROOT="$(cd "$1" && pwd)"
else
  PROJECT_ROOT="$(pwd)"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR"
# project のルート（project-template の親）
PARENT_ROOT="$(dirname "$TEMPLATE_DIR")"

# リンクは .cursor/rules/ や .cursor/prompts/ に作るため、
# リンク先は「プロジェクトルートから見たテンプレートへの相対パス」を .cursor から見た形にする
# 例: プロジェクトが project/100days-apps なら .cursor からは ../../project-template
if [[ "$PROJECT_ROOT" == "$PARENT_ROOT"/* ]]; then
  subpath="${PROJECT_ROOT#$PARENT_ROOT/}"
  segments=0
  [[ -n "$subpath" ]] && segments=$(($(echo "$subpath" | tr -cd '/' | wc -c | tr -d ' ') + 1))
  # .cursor/rules や .cursor/prompts から PARENT_ROOT へ: 2段上がってプロジェクトルート、さらに segments 段で親
  depth=$((2 + segments))
  prefix=$(printf '../%.0s' $(seq 1 "$depth"))
  REL_TEMPLATE="${prefix}project-template"
else
  # プロジェクトが project の外にある場合は絶対パスでリンク
  REL_TEMPLATE="$TEMPLATE_DIR"
fi

CURSOR_DIR="$PROJECT_ROOT/.cursor"
RULES_DIR="$CURSOR_DIR/rules"
PROMPTS_DIR="$CURSOR_DIR/prompts"

echo "プロジェクト: $PROJECT_ROOT"
echo "テンプレート: $TEMPLATE_DIR"
echo "---"

mkdir -p "$RULES_DIR" "$PROMPTS_DIR"

# .cursor/rules/template → テンプレートの .cursor/rules
if [[ -d "$TEMPLATE_DIR/.cursor/rules" ]]; then
  if [[ -L "$RULES_DIR/template" ]] || [[ -e "$RULES_DIR/template" ]]; then
    echo "既存: .cursor/rules/template (スキップ)"
  else
    ln -s "$REL_TEMPLATE/.cursor/rules" "$RULES_DIR/template"
    echo "作成: .cursor/rules/template → テンプレートの rules"
  fi
else
  echo "スキップ: テンプレートに .cursor/rules がありません"
fi

# .cursor/prompts/template → テンプレートの .cursor/prompts
if [[ -d "$TEMPLATE_DIR/.cursor/prompts" ]]; then
  if [[ -L "$PROMPTS_DIR/template" ]] || [[ -e "$PROMPTS_DIR/template" ]]; then
    echo "既存: .cursor/prompts/template (スキップ)"
  else
    ln -s "$REL_TEMPLATE/.cursor/prompts" "$PROMPTS_DIR/template"
    echo "作成: .cursor/prompts/template → テンプレートの prompts"
  fi
else
  echo "スキップ: テンプレートに .cursor/prompts がありません"
fi

echo "---"
echo "プロジェクト固有のルールは .cursor/rules/ に .md/.mdc を直置きしてください。"
echo "プロジェクト固有のプロンプトは .cursor/prompts/ に .md を直置きしてください。"
echo "完了。"
