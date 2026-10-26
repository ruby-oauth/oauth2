# shellcheck shell=bash

prepend_unique_path_value() {
  local value="$1"
  local current="$2"

  if [[ -z "$current" ]]; then
    printf '%s' "$value"
  elif [[ ":$current:" == *":$value:"* ]]; then
    printf '%s' "$current"
  else
    printf '%s:%s' "$value" "$current"
  fi
}

# Preserve existing values while prepending the project defaults needed by TreeHaver.
_tree_sitter_runtime_lib="${TREE_SITTER_RUNTIME_LIB:-/home/linuxbrew/.linuxbrew/Cellar/tree-sitter/0.26.6/lib/libtree-sitter.so}"
_tree_sitter_runtime_dir="$(dirname "${_tree_sitter_runtime_lib}")"
_tree_sitter_java_jars_dir="${TREE_SITTER_JAVA_JARS_DIR:-}"

if [[ -n "${_tree_sitter_java_jars_dir}" ]]; then
  _tree_sitter_java_jar="${_tree_sitter_java_jars_dir}/jtreesitter-0.26.0.jar"
  export CLASSPATH="$(prepend_unique_path_value "${_tree_sitter_java_jar}" "${CLASSPATH:-}")"
fi

export LD_LIBRARY_PATH="$(prepend_unique_path_value "${_tree_sitter_runtime_dir}" "${LD_LIBRARY_PATH:-}")"
