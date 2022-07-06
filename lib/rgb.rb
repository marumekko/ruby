# frozen_string_literal: true

# 整数値を16進数の文字列に変換する
p 0.to_s(16) #=>"0"
p 255.to_s(16) #=>"ff"

# "0"も２桁ほしいので rjust メソッドを使って右寄せする
# 第1引数には桁数を指定
# デフォルトは空白（半角スペース）で桁揃えされる
# 第2引数を指定すると空白以外の文字列を埋めることができる
p '0'.rjust(5) #=>"0"
p '0'.rjust(5, '0') #=>"00000"
p '0'.rjust(5, '_') #=>"____0"

p 0.to_s(16).rjust(2, '0') #=>"00"
p 255.to_s(16).rjust(2, '0') #=>"ff"

def to_hex_1(r, g, b)
  '#' +
    r.to_s(16).rjust(2, '0') +
    g.to_s(16).rjust(2, '0') +
    b.to_s(16).rjust(2, '0')
end

def to_hex_2(r, g, b)
  hex = '#'
  [r, g, b].each do |n|
    hex += n.to_s(16).rjust(2,'0')
  end
  hex
end

def to_hex_3(r, g, b)
  [r, g, b].inject('#') do |hex, n|
    hex + n.to_s(16).rjust(2, '0')
  end
end

# ポイント
# ・最初の繰り返し処理ではhexに"#"が入ること。
# ・ブロックの中のhex+n.to_s(16).rjust(2,'0')で作成された文字列は、次の繰り返し処理のhexに入ること。
# ・繰り返し処理が最後まで到達したら、ブロックの戻り値がinjectメソッド自身の戻り値になること。

def to_ints_1(hex)
  # 文字列からR（赤）、G（緑）、B（青）の各値を取り出す
  r = hex[1..2]
  g = hex[3..4]
  b = hex[5..6]

  # 16進数の文字列を10進数の整数に変換(Stringクラスのhexメソッドを使用)
  ints = []

  [r, g, b].each do |s|
    ints << s.hex
  end
  ints
end

# 処理フロー
# ・引数の文字列から3つの16進数を抜き出す。
# ・3つの16進数を配列に入れ、ループを回しながら10進数の整数に変換した値を別の配列に詰め込む。
# ・10進数の整数が入った配列を返す。

def to_ints_2(hex)
  r = hex[1..2]
  g = hex[3..4]
  b = hex[5..6]
  # 多重代入でもok -> r, g, b = hex[1..2], hex[3..4], hex[5..6]

  # map で書き換える
  [r, g, b].map do |s|
    s.hex
  end
end

def to_ints_3(hex)
  hex.scan(/\w\w/).map(&:hex)
end

# テスト駆動開発では、下記開発サイクルが基本
# ・先にテストを書いて失敗させる。
# ・テストがパスするような最小限のコードを書く。
# ・リファクタリングする。
