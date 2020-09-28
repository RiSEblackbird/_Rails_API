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

### Linterの導入([Rubocop](https://github.com/rubocop-hq/rubocop))

- [Installation](https://github.com/rubocop-hq/rubocop#installation)項を参照

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

- テストフレームワーク``RSpec``の適用
  - 本リポジトリではデフォルトを``Minitest``から``RSpec``に変更する最低限の手続きのみ
  - ``rspec-rails``, ``capybara``のみ追加
  - ``api/config/application.rb``の設定

- ``$ bundle install``

### ER図のベース ([別リポジトリからの引用](https://github.com/RiSEblackbird/_TS_Express_MySQL_with_TypeORM_API))

![for_TS_Express_bigenner_projects-withoutUser(result)](https://user-images.githubusercontent.com/43542677/92310333-48bcb800-efe8-11ea-8ae7-c037b1e888c1.png)
(この図に対して、外部キー等の整合は今回考えない)

### モデル、コントローラーの生成

- Keywordモデル
  - ``$ rails g model keyword word:string memo:text``
  - ``$ rails g controller keywords``

- Stampモデル
  - ``$ rails g model stamp keyword_id:integer study_log_id:integer``
  - ``$ rails g controller stamps``

- Study_logモデル
  - ``$ rails g model studyLog body:text``
  - ``$ rails g controller study_logs``

### リレーションの追加(マイグレーションファイル、モデルクラス)

#### 中間テーブルを介した関連付け

[2.4 has_many :through関連付け - Railsガイド](https://railsguides.jp/association_basics.html#has-many-through%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91)

- (必要な場合はDB設定)

- ``$ rails db:create``
- ``$ rails db:migrate``

~~~a
mysql> describe keywords;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | bigint(20)   | NO   | PRI | NULL    | auto_increment |
| word       | varchar(255) | NO   |     | NULL    |                |
| memo       | text         | YES  |     | NULL    |                |
| created_at | datetime(6)  | NO   |     | NULL    |                |
| updated_at | datetime(6)  | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)

mysql> describe stamps;
+--------------+-------------+------+-----+---------+----------------+
| Field        | Type        | Null | Key | Default | Extra          |
+--------------+-------------+------+-----+---------+----------------+
| id           | bigint(20)  | NO   | PRI | NULL    | auto_increment |
| keyword_id   | bigint(20)  | YES  | MUL | NULL    |                |
| study_log_id | bigint(20)  | YES  | MUL | NULL    |                |
| created_at   | datetime(6) | NO   |     | NULL    |                |
| updated_at   | datetime(6) | NO   |     | NULL    |                |
+--------------+-------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> describe study_logs;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| id         | bigint(20)  | NO   | PRI | NULL    | auto_increment |
| body       | text        | NO   |     | NULL    |                |
| created_at | datetime(6) | NO   |     | NULL    |                |
| updated_at | datetime(6) | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)
~~~

### ルーティングの設定

~~~rb
Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :keywords
      resources :stamps
      resources :study_logs
    end
  end
end
~~~

~~~a
# 以下は要所の抜粋
$ rails routes
Prefix Verb              URI Pattern                           Controller#Action
  api_v1_keywords GET    /api/v1/keywords(.:format)            api/v1/keywords#index
                  POST   /api/v1/keywords(.:format)            api/v1/keywords#create
  api_v1_keyword  GET    /api/v1/keywords/:id(.:format)        api/v1/keywords#show
                  PATCH  /api/v1/keywords/:id(.:format)        api/v1/keywords#update
                  PUT    /api/v1/keywords/:id(.:format)        api/v1/keywords#update
                  DELETE /api/v1/keywords/:id(.:format)        api/v1/keywords#destroy
    api_v1_stamps GET    /api/v1/stamps(.:format)              api/v1/stamps#index
                  POST   /api/v1/stamps(.:format)              api/v1/stamps#create
    api_v1_stamp  GET    /api/v1/stamps/:id(.:format)          api/v1/stamps#show
                  PATCH  /api/v1/stamps/:id(.:format)          api/v1/stamps#update
                  PUT    /api/v1/stamps/:id(.:format)          api/v1/stamps#update
                  DELETE /api/v1/stamps/:id(.:format)          api/v1/stamps#destroy
api_v1_study_logs GET    /api/v1/study_logs(.:format)          api/v1/study_logs#index
                  POST   /api/v1/study_logs(.:format)          api/v1/study_logs#create
api_v1_study_log  GET    /api/v1/study_logs/:id(.:format)      api/v1/study_logs#show
                  PATCH  /api/v1/study_logs/:id(.:format)      api/v1/study_logs#update
                  PUT    /api/v1/study_logs/:id(.:format)      api/v1/study_logs#update
                  DELETE /api/v1/study_logs/:id(.:format)      api/v1/study_logs#destroy
~~~

### コントローラーの整備

- コントローラーのディレクトリ階層をルーティングの階層に合わせる
  ~~~a
  controller > api > v1 > ***_controller.rb
  ~~~

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