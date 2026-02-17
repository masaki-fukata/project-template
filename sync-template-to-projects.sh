#!/usr/bin/env bash
# project-template の内容を sync-targets.txt に書かれた各プロジェクトへコピーする。
# 使い方: project ディレクトリで ./project-template/sync-template-to-projects.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR"
# project のルート = project-template の親ディレクトリ
PROJECT_ROOT="$(dirname "$TEMPLATE_DIR")"
TARGETS_FILE="$TEMPLATE_DIR/sync-targets.txt"

if [[ ! -f "$TARGETS_FILE" ]]; then
  echo "sync-targets.txt が見つかりません: $TARGETS_FILE"
  exit 1
fi

echo "テンプレート: $TEMPLATE_DIR"
echo "同期先一覧: $TARGETS_FILE"
echo "---"

while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line%%#*}"
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"
  [[ -z "$line" ]] && continue

  if [[ "$line" == /* ]]; then
    DEST="$line"
  else
    DEST="$PROJECT_ROOT/$line"
  fi

  if [[ ! -d "$DEST" ]]; then
    echo "スキップ（存在しません）: $DEST"
    continue
  fi

  echo "同期中: $DEST"

  # .cursorrules をコピー
  if [[ -f "$TEMPLATE_DIR/.cursorrules" ]]; then
    cp "$TEMPLATE_DIR/.cursorrules" "$DEST/.cursorrules"
    echo "  - .cursorrules"
  fi

  # .cursor ディレクトリを中身ごとコピー（既存は上書き）
  if [[ -d "$TEMPLATE_DIR/.cursor" ]]; then
    mkdir -p "$DEST/.cursor"
    rsync -a --delete "$TEMPLATE_DIR/.cursor/" "$DEST/.cursor/" 2>/dev/null || {
      cp -R "$TEMPLATE_DIR/.cursor/"* "$DEST/.cursor/" 2>/dev/null || true
      echo "  - .cursor/ (cp)"
    }
    echo "  - .cursor/"
  fi
done < "$TARGETS_FILE"

echo "---"
echo "同期完了"
