#!/bin/bash
# $?は直前のコマンドの終了ステータスを保持している。
# 0なら成功
# 1なら失敗
# 127だとそんなコマンドねーよになる。
if test $? -eq 0 ; then
  echo "コマンド (U^ω^) アルトくぅ〜ん"
else
  echo "コマンド失敗ᕙ( ˘ω˘ )◜⁾⁽⁽◝( ˘ω˘ )ᕗ"
fi
