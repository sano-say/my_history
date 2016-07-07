# my_history

## こういうのつくりたい
1. `.bash_history`には（あるいは`history`のキャッシュには)重複コマンドは保存しない
2. 重複していた場合は古い方を消して最下行へ履歴を追加
3. `.bash_hisotry`はコマンド実行される都度`history -a`される-> `.bash_history`は常に最新
4. `.bash_history`は、使用されるスペースの数を区別しない( 例： `ls` と `ls   ` は同一)
5. ミスコマンド(`$? != 0`)は保存しない

## 普通のhistoryはこう
1. コマンドが実行される
2. ヒストリーのキャッシュの最下行に実行したコマンドが追加される
3. `exit`したり`history -a`したりするとキャッシュが`.bash_history`にコピーされる

## my_historyはこう
1. コマンドが実行される
2. ヒストリーの・キャッシュの最下行に実行したコマンドが追加される
3. *ただし、実行時ミスしたコマンドは追加されない*
4. `exit`したり`history -a`したりするとキャッシュが`.bash_history`にコピーされる
5. *その時、追加差分に対して重複確認を行い、古い方の履歴を消去する。*

## 俺にはビルトインのhistoryに手を加える能力はないぞ
ないぞい。

## 3.ってどうやんの
```sh
[YOUR CMD] ; if test $? -eq 0 ; then echo '(U^ω^)' ; else history -d $(( $HISTCMD - 1 )) ; echo '(´；ω；｀)' ; fi
```
### これじゃだめ？
```sh
[YOUR CMD]; my_history/checkEndStatus.sh
```
**だめ。**

直前のコマンドの終了ステータスを保持する変数`$?`は`checkEndStatus.sh`が実行された時点で更新されてしまうのだ。
なので`$?`は定数`0`となってしまう。

### これも？

```sh
ailias=if test $? -eq 0 ; then echo '(U^ω^)' ; else history -d $(( $HISTCMD - 1 )) ; echo '(´；ω；｀)' ; fi
```
**だめ。(´；ω；｀)**


そういうわけで面倒だが、`checkEndStatus.sh`等によって入力を簡略化することはできなかった。

