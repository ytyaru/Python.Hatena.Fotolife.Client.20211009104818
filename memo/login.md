# はてなサイトのログインについて

　reCAPTUCHA のせいでログインできない問題。

* 2021-10-10時点
* `https://www.hatena.ne.jp/login`
* ログインできないとはてなフォトライフの公開範囲が「自分のみ」のフォルダのRSSが参照できず全画像自動取得できない
* ログインフォーム抜粋コードは以下

```html
      <form name="login" action="/login" method="post">
        <div>
<div class="error-message">
  <p>時間を空けて再度お試しください。または<a href="https://hatena.zendesk.com/hc/ja">サポート窓口</a>にお問い合わせください。</p>
</div>
          <div class="input-item">
            <div class="input-item-inner">
              <input placeholder="はてなID または メールアドレス" value="*******************" pattern=".{3,}" id="login-name" type="text" class="text" required="required" autofocus="autofocus" name="name">
            </div>
          </div>
          <div class="input-item">
            <div class="input-item-inner">
              <input class="password" type="password" name="password" required="required" placeholder="パスワード" value="*************">
            </div>
          </div>
          <div id="option" class="config-button">              <div class="auto-login">
                <a href="#" class="checkbox-tab"><label for="auto_login"></label></a>
                <div class="checkbox-item">
                  <input type="checkbox" class="checkbox" checked="checked" name="persistent" value="1" id="auto_login" />
                  <label for="auto_login" class="checkbox-text">
                    <span>次回から自動的にログイン</span>
                  </label>
                </div>
              </div>                        <input value="" name="recaptcha_token" type="hidden" />
            <button type="button" id="login-button" class="submit-button">送信する</button>
          </div>
        </div>
      </form>
```

　このうちフォームを解析すると次のとおり。

* HTTP通信方法：`POST`
* データ（`<input name>`）
    * `name`: はてなID または メールアドレス
    * `password`: パスワード
    * `persistent`: 次回から自動的にログインするか否か
    * `recaptcha_token`: 「私はボットではありません」チェックの進化版。ユーザが操作せずとも自動的にBOTチェックする。そのためにJavaScriptで実行することが必要である。

　2020-01-11頃まではログインできていた模様。

* https://koukaforest.hatenablog.com/entry/2020/01/11/010000

## reCAPTUCHA v3

* [recaptcha](https://hatoblog.net/recaptcha/)

　reCAPTUCHA のせいでJavaScriptによる実行が必要になってしまった。Cookieの実装だけでもダメ。

* [SeleniumでFirefoxブラウザのプロファイルを読み込む【Recaptcha突破、Cookie+アドオン読み込み】](https://noauto-nolife.com/post/selenium-read-profile)

> 予めブラウザでログインをしておいて、そのプロファイルを読み込めば良い。

```python
fp      = webdriver.FirefoxProfile("/home/[ユーザー名]/.mozilla/firefox/[プロファイル名].default")
browser = webdriver.Firefox(fp)
```

* [Python + Selenium + Chrome で自動ログインいくつか](https://qiita.com/memakura/items/dbe7f6edadd456da1c5d)

> 既存プロフィールで運用する場合には悪意ある運用を避けるためのセーブ機構の為に、すでにSelenium以外から立ち上げられた同プロフィールのブラウザがある場合にエラーが吐かれるのでご注意を。

* [はてなブログのアクセス数を自動で取得、表示するプログラムを作ってみる](https://nochitamama.hatenablog.com/entry/Python/autoaccess)
* [No such file or directory: 'chromedriver': 'chromedriver'の解決](https://qiita.com/jajaja/items/d7f80876519aa8c3e64c)

```sh
pip3 install selenium
pip3 install chromedriver-binary
```


* [2Captcha](https://qiita.com/derodero24/items/7d36f4617a40fbb36b11)

　2Captchaという有料ツールによってrecaptchaを突破できるらしい。

