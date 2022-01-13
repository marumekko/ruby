# frozen_string_literal: true

# 2.2.1 すべてがオブジェクト

# Rubyはオブジェクト指向言語である。数値や nil, true/false に対してもメソッドを呼び出せる

# 文字列
puts '1'.to_s #=>"1"

# 数値
puts 1.to_s #=>"1"

# nil
puts nil.to_s #=>"nil"

# true/false
puts true.to_s #=>"true"
puts false.to_s #=>"false"

# 正規表現
puts /\d+/.to_s #=>"(?-mix:\d+)"

# 2.2.2 メソッド呼び出し

# 形式 : オブジェクト.メソッド(引数1, 引数2, 引数3) ※カッコは省略可能

puts 10.to_s(16)
puts 10.to_s 16

# 2.3 文字列
# 2.3.1 シングルクオートとダブルクオート

# ダブルクオートで囲むと\nが改行文字として機能する
puts "こんにちは\nさようなら"
# =>こんにちは
# さようなら

# シングルクオートで囲むと\nはただの文字列になる
puts 'こんにちは\nさようなら'
# =>こんにちは\nさようなら

# 2.4 数値

# 数値には_を含めることができます。_は無視されるので、大きな数の区切り文字として使うと便利
puts 1_000_000_000 #=>1000000000

# 整数同士の割り算は整数になる点に注意してください。小数点以下は切り捨てられる
# 0.5ではなく0になる
puts 1 / 2 #=>0
# 小数点以下の値が必要な場合は、どちらかの値に小数点の.0を付ける
puts 1.0 / 2 #=>0.5
puts 1 / 2.0 #=>0.5

# 変数に整数が入っている場合は、to_fメソッドを呼ぶことで整数から小数に変更可能
n = 1
puts n.to_f #=>1.0
puts n.to_f / 2 #=>0.5

# **はべき乗を求める演算子です。
puts 2**3 #=>8

# 2.4.3 変数に格納された数値の増減Rubyには変数の値を増減させる++やのような演算子がありません。これに近い演算子として、+=と=が用意されている
# nを1増やす（n=n+1と同じ）
puts n += 1 #=>2

# nを1減らす（n=n1と同じ）
puts n = 1 #=>1

# 2.5.1 Ruby の真偽値
# falseまたはnilであれば偽。
# それ以外はすべて真。

data = nil

if !data.nil?
  puts 'データがあります'
else
  puts 'データはありません'
end

# Ruby の場合
if data
  puts 'データがあります'
else
  puts 'データはありません'
end

# 2.5.2 論理演算子
# 条件1 && 条件2は「条件1かつ条件2」-> 条件1も条件2も真であれば真、それ以外は偽
t1 = true
t2 = true
f1 = false
puts t1 && t2 #=>true
puts t1 && f1 #=>false

# 条件1||条件2は「条件1または条件2」-> 条件1か条件2のいずれかが真であれば真、両方偽であれば偽
# 優先順位 || < &&
t1 = true
f1 = false
f2 = false
puts t1 || f1 #=>true
puts f1 || f2 #=>false

# 2.8 文字列についてもっと詳しく
# 2.8.1 文字列は String クラスのオブジェクト
puts 'abc'.class #=>String

# 2.8.2 %記法で文字列を作る文字列はシングルクオートやダブルクオートだけでなく、%記法で作ることもできる
# %記法を使うとシングルクオートやダブルクオートをエスケープする必要なし

# %q!!はシングルクオートで囲んだことと同じになる
puts %q!(Hesaid,"Don'tspeak.")! #=>Hesaid,"Don'tspeak."

# %Q!!はダブルクオートで囲んだことと同じになる（改行文字や式展開が使える）
something = 'Hello.'
puts %!(Hesaid,"#{something}")! #=>Hesaid,"Hello."#

# %!!もダブルクオートで囲んだことと同じになる
something = 'Bye.'
puts %!(Hesaid,"#{something}")! #=>Hesaid,"Bye."

# 2.8.3ヒアドキュメント（行指向文字列リテラル）
# 文字列は途中で改行できるが、複数行に渡る長い文字列を作成する場合はヒアドキュメント（行指向文字列リテラル）を使ったほうがスッキリ書ける
# Ruby2.3以降では <<~TEXT のように~を使うと内部の文字列をインデントさせても先頭の空白部分が無視される
# TEXT は識別子
def some_method
  <<~TEXT
    これはヒアドキュメントです。
    <<~を使うと内部文字列のインデント部分が無視されます
  TEXT
end
puts some_method

#=> これはヒアドキュメントです。
# <<~を使うと内部文字列のインデント部分が無視されます。

# ヒアドキュメントの中では式展開が有効です。
# また、<<'TEXT'のように、識別子をシングルクオートで囲むと式展開が無効、ダブルクオートだと有効になる
name = 'Alice'
a = <<~TEXT
  ようこそ、#{name} さん!
  以下のメッセージをご覧ください。
TEXT
puts a

# 開始ラベルの<<識別子は1つの式と見なされるため、<<識別子をメソッドの引数として渡したり、<<識別子に対してメソッドを呼び出したりできる
# ヒアドキュメントで作成した文字列に対して、直接upcaseメソッドを呼び出す
b = <<~TEXT.upcase
  Hello,Goodbye.
TEXT
puts b
#=>HELLO,#GOODBYE

# 2.8.4 フォーマットを指定して文字列を作成する
# sprintf メソッドを使うと、指定されたフォーマットの文字列を作成できる
# -> [Style/FormatString: Favor format over sprintf] により format を使用
# 例: 少数第3位まで数字を表示する文字列を作成する
p sprintf('%0.3f', 1.2) #=> "1.200"
p format('%0.3f', 1.2) #=> "1.200"
p '%0.3f' % 1.2 #=> "1.200"

# 表示したいオブジェクトを複数渡せる
p sprintf('%0.3f+%0.3f', 1.2, 0.48) #=>"1.200+0.480"
p '%0.3f+%0.3f' % [1.2,0.48] #=>"1.200+0.480"

# 2.8.5 その他、文字列作成のいろいろ
# 数値を文字列に変換する
p 123.to_s #=>"123"

# 配列を連結して1つの文字列にする
p [10, 20, 30].join #=>"102030"

# *演算子を使って文字列を繰り返す
p 'Hi!' * 10 #=>"Hi!Hi!Hi!Hi!Hi!Hi!Hi!Hi!Hi!Hi!"

# String.newを使って新しい文字列を作る（あまり使わない）
p String.new('hello') #=>"hello"

# 2.8.6 文字と文字列の違いはない
# ほかのプログラミング言語では1文字だけの「文字」と、複数文字の「文字列」を別々に扱うものもあるが、Rubyでは違いはない
# いずれも「文字列（Stringオブジェクト）」として扱われる
# ?をつかって1文字だけの文字列を作ることもできる
p ?a #=> "a"

# 2.9 数値についてもっと詳しく
# 2.9.1 10進数以外の整数リテラル
# 2進数の場合は0b、8進数の場合は0、16進数の場合は0xを先頭に付けると、それぞれ10進数以外の整数値を作成できます。
# 2進数
p 0b11111111 #=>255

# 8進数 (0 -> 0o)
p 0o377 #=>255

# 16進数
p 0xff #=>255

# 2.9.2 ビット演算
# 整数値は次の演算子を使ってビット演算ができる
# ~：ビット反転
# &：ビット積
# |：ビット和
# ^：排他的論理和
# >>：右ビットシフト
# <<：左ビットシフト

# 以下はビット演算を行う例（結果を2進数で確認できるように、to_s(2)を呼び出している）

p((~0b1010).to_s(2)) #=>"-1011"
p((0b1010 & 0b1100).to_s(2)) #=>"1000"
p((0b1010 | 0b1100).to_s(2)) #=>"1110"
p((0b1010 ^ 0b1100).to_s(2)) #=>"110"
p((0b1010 >> 1).to_s(2)) #=>"101"
p((0b1010 << 1).to_s(2)) #=>"10100"

# 2.9.3 指数表現
# 指数表現を使って浮動小数点数を表すことができる
# 2e3は「2×10の3乗」で0.002の意味になる
p 2e3 #=>0.002

# 2.9.4 数値クラスのあれこれ
# 整数
p 10.class #=>Integer
# 小数
p 1.5.class #=>Float
# 有理数リテラルを使う（3rが有理数リテラル）
r = 2/3r
p r #=>(2/3)
p r.class #=>Rational
# 文字列から有理数に変換する
r = '2/3'.to_r
p r #=>(2/3)
p r.class #=>Rational
# 複素数リテラルを使う（0.5iが複素数リテラル）
c = 0.3 - 0.5i
p c #=>(0.3-0.5i)
p c.class #=>Complex
# 文字列から複素数に変換する
c = '0.3-0.5i'.to_c
p c #=>(0.3-0.5i)
p c.class #=>Complex

# ちなみに、Ruby2.3までの整数は非常に大きな数の場合はBignumクラス、それ以外はFixnumクラスに分かれていたが、
# Ruby2.4からは整数はすべてIntegerクラスにまとめられた
# ここでの数値クラスはすべて Numeric クラスのサブクラス

# 2.10 真偽値と条件分岐についてもっと詳しく
# 2.10.1 && や || の戻り値と評価を終了するタイミング
# && や || を使った場合、式全体の戻り値は必ずしも true または false になるとは限らない

p 1 && 2 && 3 #=>3
p 1 && nil && 3 #=>nil
p 1 && false && 3 #=>false
p nil || false #=>false
p false || nil #=>nil
p nil || false || 2 || 3 #=>2

# Rubyは式全体が真または偽であることが決定するまで左辺から順に式を評価する
# 式全体の真または偽が確定すると、式の評価を終了し、最後に評価した式の値を返す
# たとえば、1 && 2 && 3であれば、すべての式を評価する必要があったため、最後の式である3が戻り値になる
# 一方、1 && nil && 3 は2つめの nil を評価した時点で式全体の真偽値が偽であることが確定したため、そこで評価を終了し、nilを返す
# || の場合も、nil || false || 2 || 3 の戻り値が2になるのは、2を評価した時点で式全体の真偽値が真であることが確定したためである
# if文のように「真または偽のどちらか」であればかまわないケースでは、戻り値が具体的に何であるか意識する必要はない
# しかし、Rubyでは if 文以外のところで && や || を意図的に使う場合がある

# 以下は||を使った式の戻り値や、真偽値が確定した時点で評価が終了されることを活用した架空のコード例
# Alice、Bob、Carol と順に検索し、最初に見つかったユーザ（nilまたはfalse以外の値）を変数に格納する
# user = find_user('Alice') || find_user('Bob') || find_user('Carol')
# 正常なユーザであればメールを送信する（左辺が偽であればメール送信は実行されない）
# user.valid? && send_email_to(user)

# 2.10.2 優先順位が低いand、or、not
# &&, ||, ! に近い働きをする演算子としてand、or、notがある
t1 = true
f1 = false
t1 and f1 #=>false
t1 or f1 #=>true
not t1 #=>false

# 優先順位 ! > && > || > not > and = or
# &&, || と異なり、and と orは優先順位に違いがないため()を使わない場合は左から右に順番に真偽値が評価されていく
# このような特徴があるため、and や or を && や || の代わりに使おうとすると思いがけない不具合を招く可能性がある
# and や or は条件分岐で使うのではなく、制御フローを扱うのに向いている

# 2.10.3 unless文
# 条件式が偽になった場合だけ処理を実行する

# if の場合
status = 'error'
message =
  if status != 'ok'
    '何か異常があります'
  else
    '正常です'
  end
p message # =>"何か異常があります"

# unless の場合 -> [Do not use `unless` with `else`.
# Rewrite these with the positive case first. (convention:Style/UnlessElse)]
status = 'error'
message =
  unless status=='ok'
    '何か異常があります'
  else
    '正常です'
  end
p message # =>"何か異常があります"

# 2.10.4 case文
# 複数の条件を指定する場合は、elsifを重ねるよりもcase文で書いたほうがシンプル

# 構文
# case 対象のオブジェクトや式
# when 値1
#   値1に一致する場合の処理
# when 値2
#   値2に一致する場合の処理
# when 値3
#   値3に一致する場合の処理
# else
#   どれにも一致しない場合の処理
# end

# if の場合
country = 'italy'
greeting =
  if country == 'japan'
    'こんにちは'
  elsif country == 'us'
    'Hello'
  elsif country == 'italy'
    'ciao'
  else
    '???'
  end
p greeting # => "ciao"

# case の場合
greeting =
  case country
  when 'japan'
    'こんにちは'
  when 'us'
    'Hello'
  when 'italy'
    'ciao'
  else
    '???'
  end
p greeting # => "ciao"

# Ruby の case 文では when 節に複数の値を指定し、どれかに一致すれば処理を実行する、という条件分岐が書ける
# when 節に複数の値を指定する
country = 'アメリカ'
case country
when 'japan', '日本'
  'こんにちは'
when 'us', 'アメリカ'
  'Hello'
when 'italy', 'イタリア'
  'ciao'
else
  '???'
end

# then を入れると when 節とその条件が真だった場合の処理を1行で書ける(使用頻度低)
country = 'italy'
case country
when 'japan' then 'こんにちは'
when 'us' then 'Hello'
when 'italy 'then 'ciao'
else '???'
end

# 2.10.5 条件演算子(三項演算子)
# 式 ? (真だった場合の処理) : (偽だった場合の処理)
# if の場合
n = 11
result =
  if n > 10
    '10より大きい'
  else
    '10以下'
  end
p result #=>"10より大きい"

# 条件演算子の場合
n = 11
result = n > 10 ? '10より大きい' : '10以下'
p result #=>"10より大きい"

# 2.11 メソッド定義についてもっと詳しく
# 2.11.1 デフォルト値つきのメソッド
# Rubyではメソッドを呼び出す際に引数の過不足があるとエラーになる
def greeting(country)
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end

# 引数が少ない
# greeting
# =>ArgumentError:wrongnumberofarguments(given0,expected1)

# 引数がちょうど
p greeting('us') # =>"hello"

# 引数が多い
# greeting('us', 'japan')
# =>ArgumentError:wrongnumberofarguments(given2,expected1)

# 引数にデフォルト値を付ける場合
# def メソッド(引数1 = デフォルト値1, 引数2 = デフォルト値2)
#   必要な処理
# end

# 引数なしの場合は country に'japan'を設定する
def greeting2(country = 'japan')
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
p greeting2 #=>"こんにちは"
p greeting2('us') #=>"hello"

# 2.11.2 ? で終わるメソッド
# 慣習として真偽値を返す
# 例：空文字列であればtrue、そうでなければfalse
p ''.empty? # =>true
p 'abc'.empty? # =>false

# 自分で定義する場合、真偽値を返す目的のメソッドであれば ?で終わらせるようにしたほうが良い
# 3の倍数ならtrue、それ以外はfalseを返す
def multiple_of_three?(n)
  (n % 3).zero?
end
p multiple_of_three?(4) #=>false
p multiple_of_three?(5) #=>false
p multiple_of_three?(6) #=>true

# 2.11.3 !で終わるメソッド
# 慣習として「使用する際は注意が必要」という意味を持つ
a = 'ruby'
# upcase だと変数 a の値は変化しない
p a.upcase #=>"RUBY"
p a #=>'ruby'

# upcase! だと変数 a の値も大文字に変わる
# p a.upcase! #=>"RUBY"
# p a #=>"RUBY"
# -> [in `upcase!': can't modify frozen String: "ruby" (FrozenError)]
# なお、このように呼び出したオブジェクトの状態を変更してしまうメソッドのことを「破壊的メソッド」と呼ぶ

# 2.12 その他の基礎知識
# 2.12.1 ガベージコレクション(GC)
# Ruby は使用されなくなったオブジェクトを回収し、自動的にメモリを解放する
# このため、プログラマはメモリ管理を意識する必要がない

# 2.12.2 エイリアスメソッド
# Ruby にはまったく同じメソッドに複数の名前が付いている場合がある
# 例：lengthもsizeも、どちらも文字数を返す
p 'hello'.length #=>5
p 'hello'.size #=>5

# 2.12.3 式（Expression）と文（Statement）
# 「値を返し、結果を変数に代入できるものが式」「値を返さず、変数に代入しようとすると構文エラーになるものが文」と定義する
# if 文が値を返すので変数に代入できる
a =
  if true
    '真です'
  else
    '偽です'
  end
p a #=>"真です"

# メソッドの定義も実は値（シンボル）を返している
b = def foo; end
p b #=>:foo

# 2.12.4 擬似変数
# nil と true と false は擬似変数と呼ばれる特殊な変数
# self：オブジェクト自身
# __FILE__：現在のソースファイル名
# __LINE__：現在のソースファイル中の行番号
# __ENCODING__：現在のソースファイルのスクリプトエンコーディング
# 擬似変数は文法上、変数のように見えるが、代入しようとするとエラーが発生する￥

# 2.12.5 参照の概念を理解する
# Ruby の変数にはオブジェクトそのものではなく、オブジェクトへの参照が格納されている
# 変数を他の変数に代入したり、メソッドの引数として渡したりすると、新しい変数やメソッドの引数は元の変数と同じオブジェクトを参照する
# 変数がどのオブジェクトを参照しているのかは object_id メソッドを使うとわかる(idが同じなら同じオブジェクトを参照している）
# aとbはどちらも同じ文字列だが、オブジェクトとしては別物
a = 'hello'
b = 'hello'
p a.object_id #=>70182231931400
p b.object_id #=>70182236321960

# c に b を代入する -> b と c はどちらも同じオブジェクト
c = b
p c.object_id #=>70182236321960

# メソッドの引数にcを渡す -> 引数として受け取った d は b, c と同じオブジェクト
def m(d)
  d.object_id
end
p m(c) #=>70182236321960

# equal? メソッドを使って同じオブジェクトかどうか確認しても良い（trueなら同じオブジェクト）
p a.equal?(b) #=>false
p b.equal?(c) #=>true

# 2.12.6 組み込みライブラリ、標準ライブラリ、gem
# Ruby では最初から数多くのライブラリが標準ライブラリとして用意されている
# その中でもとくに利用頻度が高いライブラリは組み込みライブラリとして提供されている
# 文字列の String クラスや、数値の Integer クラスは組み込みライブラリ
# 一方、標準ライブラリではあるものの、組み込みライブラリではないライブラリ(たとえば日付を扱うDateクラス)もある
# 有志の開発者が作成している外部ライブラリは gem と呼ばれる形式でパッケージングされる

# 2.12.7 require
# 組み込みライブラリでない標準ライブラリや gem を利用する場合は、明示的にそのライブラリを読み込む必要がある
# require ライブラリ名
# Date クラスは組み込みライブラリではない為、そのままでは使用できない
begin
  Date.today
rescue => e
  p e #=>NameError:uninitializedconstantDate
end

# date ライブラリを読み込むと Date クラスが使えるようになる
require 'date'
p Date.today #=>#<Date:20170407((2457851j,0s,0n),+0s,2299161j)>

# 2.12.8 load
# require は1回しかライブラリやrbファイルを読み込まない
# requireを使ったときにfalseが返ってきた場合は、すでに読み込み済みであることを示している
# 自分で書いたプログラムを読み込む
# require './sample' #=>true
# 不具合があったため、sample.rbを修正する
# しかし、もう一度requireしてもすでに読み込み済みなので修正が反映されない
# require './sample' #=>false
# こういう場合は require ではなく load を使うと、毎回無条件に指定したファイルを読み込むことができる
# load './sample.rb' #=>true
# loadを使うと無条件に再読み込みできる（なのでファイルの変更が反映される）
# load './sample.rb' #=>true
# ただし、load を使う場合は拡張子の .rb は省略不可

# 2.12.9 require_relative
# require は Ruby を実行しているディレクトリがパスの起点になるが、
# require_relative を使うと自分のファイルが存在するディレクトリがパスの起点になる

# 2.12.10 putsメソッド、printメソッド、pメソッド
# putsメソッド: 一般ユーザ向け, 引数で渡されたオブジェクトに対して to_s メソッドを呼び出す, 文字列の終端に改行を加える
# printメソッド: 一般ユーザ向け, 引数で渡されたオブジェクトに対して to_s メソッドを呼び出す, 文字列の終端に改行を加えない
# pメソッド: 開発者向け, 引数で渡されたオブジェクトに対して inspect メソッドを呼び出す
# 文字列をinspectすると、ダブルダブルクオート付きの文字列が返る
p 'abc'.inspect #=>"\"abc\""
# puts と print では配列の表示が異なる
