#!/bin/zsh
# 格闘ライオンNEWS 自動運用ランナー（cronから30分毎に実行）
# 1) ニュース収集＋サイト再生成  2) 配信サーバーが落ちていたら自動再起動
BASE="/Users/apple/動画生成/kakutou-news"
PORT=8901

/usr/bin/python3 "$BASE/collector.py" >> "$BASE/logs/collect.log" 2>&1

if ! /usr/sbin/lsof -i :$PORT -sTCP:LISTEN > /dev/null 2>&1; then
  cd "$BASE/site" && nohup /usr/bin/python3 -m http.server $PORT >> "$BASE/logs/server.log" 2>&1 &
  echo "$(date '+%Y-%m-%d %H:%M') server restarted on :$PORT" >> "$BASE/logs/collect.log"
fi
