# DMM WebCamp メンター向け課題レビューコンテナ

## 注意

* macOS + Google Chrome環境を前提としています
  * make checkの中で`open -a "Google Chrome"`を使っているため、たぶんここでコケます

## 準備

### env
```shell
cp .env.sample .env
```

* .envにレビューで利用するGitHub/GitLabユーザ名／パスワードを記載

### 利用するベースイメージを用意しておく

```shell
make build-all-base
```

## コマンド

### 共通

#### レビュー終了後
1つのレビューが終了したら、Ctrl+Cでログを閉じましょう。

次に、このコマンドで作成したイメージやコンテナを削除しましょう。
```shell
make finish
```

### 1ヶ月目レビュー

#### Bookers/Bookers2
```shell
make check-bookers USER=<GITHUB_USER_NAME> REPO=<REPOSITORY_NAME> BRANCH=<BRANCH_NAME>
```
* 引数
  * USER: GitHubのユーザ名
  * REPO: リポジトリ名
  * BRANCH: レビュー対象ブランチ名(mainなら省略可)
    * masterでの提出が多いので要確認！
* 仕様
  * Ruby 3.1.2

※ GitHubのルートディレクトリがRailsのルート(GemFileがあるところ)ではない場合は、
以下のようにディレクトリを指定できます。
```shell
make check-bookers USER=ukwhatn REPO=dmm-webcamp APP_DIR="task2/bookers"
```

#### Bookersデバッグ課題レビュー(S2スキルアップ研修)
```shell
make check-s2-bookers USER=<GITHUB_USER_NAME>
```
* 仕様
  * Ruby 2.6.3
  * rspecは実行されません
  * githubをソースとしています
    * envにレビュー用Gitlabアカウントの情報をセットしておいてください
  * リポジトリ名の入力は不要です(`bookers2_phase2_debug_Rails6`を自動的に利用)

### 2ヶ月目レビュー
#### NaganoCake(S2スキルアップ研修)
```shell
make check-nc USER=<GITHUB_USER_NAME>
```
* 仕様
  * Ruby 2.6.3
  * ソースはgithubになっています
    * envにレビュー用Gitlabアカウントの情報をセットしておいてください
  * リポジトリ名の入力は不要です(`naganoCake-rails6`を自動的に利用)
* リポジトリのRubyバージョンが3.1.2になっている場合は、`check-nc`の代わりに`check-nc-ruby3`を実行してください
  * Gemfileで確認できます

## イレギュラーなケース
* S2スキルアップ研修などのテンプレートが設定されている場合は、テンプレートのRubyバージョンに合わせて記載しています
  * もしRubyバージョンが変更されている場合は、Makefileの該当コマンドに記載されているコマンド群(3つあります)について、VERを変更して手動で実行してください


## 課題
* 毎回bundle installするので2分くらいかかる
  * もう1つイメージ噛ませて使い回せるようにできないか
