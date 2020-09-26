# 

## [Rails による API 専用アプリケーション - Railsガイド](https://railsguides.jp/api_app.html)

## 工程

### 初期準備

- ``$ mkdir api client``
  - ``$ touch Gemfile Gemfile.lock``
  - ``cd ..``
- ``.gitignore``を設定

### Rails API

- ``$ rails new . --api --database=mysql --skip-bundle``

------

### 初期準備

- ``$ mkdir backend frontend``
- ``$ cd backend``
  - ``$ touch Dockerfile Gemfile Gemfile.lock``
  - ``cd ..``
- ``$ touch frontend/Dockerfile docker-compose.yml .env``

- ``.gitignore``を設定

- 各ファイル更新

### Rails

- ``$ docker-compose run --no-deps --rm backend rails new . -G --force --api --database=mysql --skip-bundle``
  - rails
    - ``new .`` : 作業ディレクトリを親としてアプリケーションを生成
      - ``-G --force`` : gitの設定をスキップする
      - ``--api`` : APIモードで生成
      - ``--database=mysql`` : DBにMySQLを指定
      - ``--skip-bundle`` : 標準Gemのインストールをスキップする
        - [Rubyアソシエーション: アプリケーションの土台作成](https://www.ruby.or.jp/ja/tech/development/web_application/tutorial/step1.html)
- ``backend/.env``の設定 : ``MYSQL_ROOT_PASSWORD=password``

- Gem : ``dotenv-rails`` の導入
  - 先出の``.env``を使用して環境変数を設定するGem

- DB設定の変更 : ``database.yml``

### Nuxt

- ``docker-compose run --rm frontend npx create-nuxt-app .``
  
  ~~~a
  $ docker-compose run --rm frontend npx create-nuxt-app .
  Creating _rails_nuxt_prac_frontend_run ... done
  internal/modules/cjs/loader.js:896
    throw err;
    ^

  Error: Cannot find module '/root/.npm/_npx/1/lib/node_modules/create-nuxt-app/node_modules/ejs/postinstall.js'
      at Function.Module._resolveFilename (internal/modules/cjs/loader.js:893:15)
      at Function.Module._load (internal/modules/cjs/loader.js:743:27)
      at Function.executeUserEntryPoint [as runMain] (internal/modules/run_main.js:72:12)
      at internal/main/run_main_module.js:17:47 {
    code: 'MODULE_NOT_FOUND',
    requireStack: []
  }
  npm ERR! code ELIFECYCLE
  npm ERR! errno 1
  npm ERR! ejs@2.7.4 postinstall: `node ./postinstall.js`
  npm ERR! Exit status 1
  npm ERR!
  npm ERR! Failed at the ejs@2.7.4 postinstall script.
  npm ERR! This is probably not a problem with npm. There is likely additional logging output above.

  npm ERR! A complete log of this run can be found in:
  npm ERR!     /root/.npm/_logs/2020-09-26T11_52_08_180Z-debug.log
  Install for [ 'create-nuxt-app@latest' ] failed with code 1
  ~~~
  