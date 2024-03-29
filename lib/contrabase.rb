#!/usr/bin/env ruby

MAP = {

  'A' => [ 'abacus', 'alicante' ],
  'B' => [ 'brother', 'bosphorus' ],
  'C' => [ 'candid', 'charred' ],
  'D' => [ 'desert', 'delicacy' ],
  'E' => [ 'elegy', 'ectoplasm' ],
  'F' => [ 'fried', 'fire' ],
  'G' => [ 'goose', 'glib' ],
  'H' => [ 'hubris', 'hawk' ],
  'I' => [ 'iconoclast', 'icon' ],
  'J' => [ 'job', 'jungle' ],
  'K' => [ 'kill', 'korea' ],
  'L' => [ 'list', 'larva'  ],
  'M' => [ 'mole', 'missile' ],
  'N' => [ 'north', 'nadir' ],
  'O' => [ 'obsidian', 'orc' ],
  'P' => [ 'paralyse', 'pride' ],
  'Q' => [ 'quartz', 'quantum' ],
  'R' => [ 'rebar', 'rival' ],
  'S' => [ 'strict', 'syria' ],
  'T' => [ 'turbine', 'triple' ],
  'U' => [ 'ural', 'umbrella' ],
  'V' => [ 'viking', 'vigilant' ],
  'W' => [ 'wagon', 'window' ],
  'X' => [ 'xylophone', 'xenon' ],
  'Y' => [ 'yonder', 'yodel' ],
  'Z' => [ 'zircon', 'zap' ],

  'a' => [ 'arabesque', 'ant' ],
  'b' => [ 'bro', 'bond' ],
  'c' => [ 'challenge', 'chart' ],
  'd' => [ 'defy', 'derivative' ],
  'e' => [ 'error', 'expert' ],
  'f' => [ 'failure', 'fan' ],
  'g' => [ 'grid', 'gullible' ],
  'h' => [ 'honourable', 'ham' ],
  'i' => [ 'irk', 'igloo' ],
  'j' => [ 'jerry', 'junk' ],
  'k' => [ 'kindness', 'kettle' ],
  'l' => [ 'lamp', 'lecture' ],
  'm' => [ 'military', 'mettle' ],
  'n' => [ 'nausea', 'night' ],
  'o' => [ 'option', 'owl' ],
  'p' => [ 'parachute', 'price' ],
  'q' => [ 'quandary', 'quantitative' ],
  'r' => [ 'rock', 'risk' ],
  's' => [ 'suffix', 'settle' ],
  't' => [ 'trip', 'trigger' ],
  'u' => [ 'utopia', 'universe' ],
  'v' => [ 'vizir', 'verse' ],
  'w' => [ 'wonder', 'whale' ],
  'x' => [ 'xenon', 'xenophobia' ],
  'y' => [ 'yellow', 'yank' ],
  'z' => [ 'zeppelin', 'zebra' ],

  '0' => [ 'abacus', 'nil' ],
  '1' => [ 'bench', 'one' ],
  '2' => [ 'casino', 'two' ],
  '3' => [ 'derivative', 'thrice' ],
  '4' => [ 'energy', 'four' ],
  '5' => [ 'five', 'pentathlon' ],
  '6' => [ 'grumpy', 'geezer' ],
  '7' => [ 'hug', 'seven' ],
  '8' => [ 'imagination', 'eight' ],
  '9' => [ 'jurist', 'nine' ],

  '+' => [ 'plus', 'add' ],
  '/' => [ 'slash', 'divide' ],
  '=' => [ 'pad', 'dot' ] }

RMAP =
  MAP.inject({}) { |h, (k, v)| v.each { |vv| h[vv] = k }; h }

SEPS =
  [ ' ' ] * 50 +
  [ ', ' ] * 5 +
  [ '. ' ] * 4 +
  [ '; ', ' : ', ' / ', '... ' ]

require 'base64'

def cap(word, p=0.28)

  Random.rand < p ? word[0, 1].upcase + word[1..-1] : word
end

def encode(path)

  puts; puts(Base64.encode64(File.read(path))
    .split("\n").join('')
    .each_char.inject('') { |s, c| s + cap(MAP[c].sample) + SEPS.sample })
end

def decode(path, i)

  File.read(path).split(/\n+/).each do |s|
    s = s.strip; next if s == ''
    s1 = s.downcase.split(/[.,;:\/ ]+/).inject('') { |ss, e| ss + RMAP[e] }
puts(Base64.decode64(s1))
    #File.open("#{path}.#{i}.out", 'wb') do |f|
      #f.write(Base64.decode64(s1))
    #end
  end
end

opts, paths = ARGV.partition { |a| a.start_with?('-') }

flags = { dir: 'encode' }
flags[:dir] = 'decode' if opts.include?('-d') || opts.include?('--decode')

paths.each_with_index do |path, i|

  if flags[:dir] == 'encode'
    encode(path)
  else
    decode(path, i)
  end
end

