# DMM WebCamp メンター向け課題レビューコンテナ

## 注意

* macOS + Google Chrome環境を前提としています
  * make checkの中で`open -a "Google Chrome"`を使っているため、たぶんここでコケます

## レビューの見方

## コマンド

### 共通

#### レビュー終了後
1つのレビューが終了したら、このコマンドで作成したイメージやコンテナを削除しましょう。
```shell
make finish
```

### 1ヶ月目レビュー

#### Bookers
```shell
make check-bookers USER=<GITHUB_USER_NAME> REPO=<REPOSITORY_NAME>
```
* USER: GitHubのユーザ名
* REPO: リポジトリ名

※ GitHubのルートディレクトリがRailsのルート(GemFileがあるところ)ではない場合は、
以下のようにディレクトリを指定できます。
```shell
make check-bookers USER=ukwhatn REPO=dmm-webcamp APP_DIR="task2/bookers"
```


