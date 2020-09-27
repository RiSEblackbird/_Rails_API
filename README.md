# _Rails_API_

(This repository is my own self-study document )

## リポジトリの目的

- ``Rails API``の基礎学習
- 学習記録/自分用資料まとめ

## 主なリファレンス

- [Railsで超簡単API - Qiita](https://qiita.com/k-penguin-sato/items/adba7a1a1ecc3582a9c9)

- [Ruby on Rails ガイド：体系的に Rails を学ぼう](https://railsguides.jp/)
  - [Rails による API 専用アプリケーション - Railsガイド](https://railsguides.jp/api_app.html)

- [Railsドキュメント](https://railsdoc.com/)

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
- ``$ bundle install``

### ER図 ([別リポジトリからの引用](https://github.com/RiSEblackbird/_TS_Express_MySQL_with_TypeORM_API))

![for_TS_Express_bigenner_projects-withoutUser(result)](https://user-images.githubusercontent.com/43542677/92310333-48bcb800-efe8-11ea-8ae7-c037b1e888c1.png)

### モデル、コントローラーの生成

- Keywordモデル
  - ``$ rails g model keyword word:string memo:text``
  - ``$ rails g controller keyword``

- Stampモデル
  - ``$ rails g model stamp keywordId:integer studyLogId:integer``
  - ``$ rails g controller stamp``

- Study_logモデル
  - ``$ rails g model studyLog body:text``
  - ``$ rails g controller studyLog``

### リレーションの追加(マイグレーションファイル、モデルクラス)

- ``Keyword`` <-> ``Stamp``

- ``Stamp`` <-> ``Study_log``

- ``$ rails db:create``

## Tips

### Rails APIについて

- Rails による API 専用アプリケーション
  - <https://railsguides.jp/api_app.html>
- [Railsで超簡単API - Qiita](https://qiita.com/k-penguin-sato/items/adba7a1a1ecc3582a9c9)

### デフォルトのテストフレームワークをRSpecに指定する

- ``api/config/application.rb``にて設定する
  - [Rails アプリケーションを設定する - Railsガイド](https://railsguides.jp/configuring.html)
    - [3.3 ジェネレータを設定する](https://railsguides.jp/configuring.html#%E3%82%B8%E3%82%A7%E3%83%8D%E3%83%AC%E3%83%BC%E3%82%BF%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)
  
  ~~~rb
  # config.generatorsの設定を変更する
  config.generators do |g|
    g.test_framework :rspec
  end
  ~~~

### 関連付け

- [Active Record の関連付け - Railsガイド](https://railsguides.jp/association_basics.html)

### 外部キー

- [Active Record マイグレーション - Railsガイド](https://railsguides.jp/active_record_migrations.html)
  - [3.6 外部キー](https://railsguides.jp/active_record_migrations.html#%E5%A4%96%E9%83%A8%E3%82%AD%E3%83%BC)

### i18n 1.1 について

- 最初の``$ bundle install``の際に下記メッセージが表示された
- 今回は多言語対応を実装しないが、メッセージの指示に従って変更しておく
  
  ~~~a
  HEADS UP! i18n 1.1 changed fallbacks to exclude default locale.
  But that may break your application.

  If you are upgrading your Rails application from an older version of Rails:

  Please check your Rails app for 'config.i18n.fallbacks = true'.
  If you're using I18n (>= 1.1.0) and Rails (< 5.2.2), this should be
  'config.i18n.fallbacks = [I18n.default_locale]'.
  If not, fallbacks will be broken in your app by I18n 1.1.x.

  If you are starting a NEW Rails application, you can ignore this notice.

  For more info see:
  https://github.com/svenfuchs/i18n/releases/tag/v1.1.0
  ~~~

### Ignoring nokogiri-x.xx.x because its extensions are not built. Try: gem pristine nokogiri --version x.xx.x

- [Command Reference - RubyGems Guides](https://guides.rubygems.org/command-reference/)
  - [GEM PRISTINE](https://guides.rubygems.org/command-reference/#gem-pristine)
- 最初のモデル生成時に大量のメッセージ
  - [ruby on rails - Ignoring gems because its extensions are not built - Stack Overflow](https://stackoverflow.com/questions/48339706/ignoring-gems-because-its-extensions-are-not-built)
  - ``$ gem pristine --all``で対処

  ~~~a
  Ignoring nokogiri-1.9.1 because its extensions are not built. Try: gem pristine nokogiri --version 1.9.1
  Ignoring nokogiri-1.8.5 because its extensions are not built. Try: gem pristine nokogiri --version 1.8.5
  Ignoring nokogiri-1.10.5 because its extensions are not built. Try: gem pristine nokogiri --version 1.10.5
  Ignoring nokogiri-1.10.4 because its extensions are not built. Try: gem pristine nokogiri --version 1.10.4
  Ignoring nokogiri-1.10.3 because its extensions are not built. Try: gem pristine nokogiri --version 1.10.3
  Ignoring nokogiri-1.10.2 because its extensions are not built. Try: gem pristine nokogiri --version 1.10.2
  Ignoring nokogiri-1.10.1 because its extensions are not built. Try: gem pristine nokogiri --version 1.10.1
  ......
  ~~~