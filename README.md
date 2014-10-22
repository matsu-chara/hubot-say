# hubot-say

* speak every statement by say command (say command is needed. so this hubot-script can use only mac)

* if statement starts with space, say command will be skipped (`/^[^\s].*$/`)

### installation

* `npm install --save say-hubot`

* save below environmental variables

```sh
export SAY_HUBOT_ENGLISH_VOICE="Alex"
export SAY_HUBOT_JAPANESE_VOICE="Otoya"
```

* if you need japanese voice, you must download voice from mac system config menu (システム環境設定＞音声入力と読み上げ＞テキスト読み上げ). if you don't need japanese voice, you can just set english voice name into environmental variables above.

* add "hubot-say" into external-scripts.json

### execSync compile failed

this scripts use [execSync](https://github.com/mgutz/execSync). if `execSync native compile failed` when `npm install`. you should check availability of python. you can also use [node-gyp](https://github.com/TooTallNate/node-gyp#installation) for build execSync(`npm install -g node-gyp`)

#### memo

if you want use [hubot-twitter-userstream](https://github.com/hoo89/hubot-twitter-userstream/) & you want saying your account's tweet

comment out

```coffeescript
return if @botUser.id == tweet.user.id # at line 63
```

at `node_modules/hubot-twitter-userstream/src/twitter-userstream.coffee`
