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

def encode(path)

  puts; puts(Base64.encode64(File.read(path))
    .split("\n").join('')
    .each_char.inject('') { |s, c| s + MAP[c].sample + SEPS.sample })
end

ARGV.each do |path|

  encode(path)
end

