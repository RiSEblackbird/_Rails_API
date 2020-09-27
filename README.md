# _Rails_API_

## リポジトリの目的

- ``Rails API``の基礎学習
- 学習記録/自分用資料まとめ

## 主なリファレンス

- [Railsで超簡単API - Qiita](https://qiita.com/k-penguin-sato/items/adba7a1a1ecc3582a9c9)

- [Rails による API 専用アプリケーション - Railsガイド](https://railsguides.jp/api_app.html)

## 工程

### 初期準備

- ``$ mkdir api client``
  - ``$ touch Gemfile Gemfile.lock``
  - ``cd ..``
- ``.gitignore``を設定

### Rails API

- アプリケーションの準備
  - ``$ rails new ./api --api --database=mysql --skip-bundle``
    - rails
      - ``new .`` : 作業ディレクトリを親としてアプリケーションを生成
        - (``-G --force`` : gitの設定をスキップする)
        - ``--api`` : APIモードで生成
        - ``--database=mysql`` : DBにMySQLを指定
        - ``--skip-bundle`` : 標準Gemのインストールをスキップする
          - [Rubyアソシエーション: アプリケーションの土台作成](https://www.ruby.or.jp/ja/tech/development/web_application/tutorial/step1.html)

### ER図 ([別リポジトリからの引用](https://github.com/RiSEblackbird/_TS_Express_MySQL_with_TypeORM_API))

![for_TS_Express_bigenner_projects-withoutUser(result)](https://user-images.githubusercontent.com/43542677/92310333-48bcb800-efe8-11ea-8ae7-c037b1e888c1.png)

### モデル、コントローラーの生成

- Keywordモデル
  - ``$ rails g model keyword word:string memo:text``
  - ``$ rails g controller keyword``

- Stampモデル
  - ``$ rails g model stamp keyword_id:integer study_log_id:integer``
  - ``$ rails g controller stamp``

- Study_logモデル
  - ``$ rails g model study_log body:text``
  - ``$ rails g controller study_log``

### リレーションの追加(マイグレーションファイル、モデルクラス)

- ``Keyword`` <-> ``Stamp``

- ``Stamp`` <-> ``Study_log``

- ``$ rails db:create``

## Tips

### Rails APIについて

- Rails による API 専用アプリケーション
  - <https://railsguides.jp/api_app.html>
- [Railsで超簡単API - Qiita](https://qiita.com/k-penguin-sato/items/adba7a1a1ecc3582a9c9)
