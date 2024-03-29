#!/usr/bin/env ruby

MAP = {

  'A' => %w[ ask ace apple ],
  'B' => %w[ brother bat box broom ],
  'C' => %w[ candid charred cat crisp ],
  'D' => %w[ desert delicacy dog drake ],
  'E' => %w[ elegy ectoplasm egg exile ],
  'F' => %w[ fried fire fox fable ],
  'G' => %w[ goose glib gun grape ],
  'H' => %w[ hubris hawk hat house ],
  'I' => %w[ iconoclast icon ink index ],
  'J' => %w[ job jungle jam jolly ],
  'K' => %w[ kill korea key kneel ],
  'L' => %w[ list larva log latch ],
  'M' => %w[ mole missile mug magic ],
  'N' => %w[ north nadir net noble ],
  'O' => %w[ obsidian orc obsolete ocean ],
  'P' => %w[ paralyse pride pen plead ],
  'Q' => %w[ quartz quantum quill quilt ],
  'R' => %w[ rebar rival rat royal ],
  'S' => %w[ strict syria sun stalk ],
  'T' => %w[ turbine triple top tidal ],
  'U' => %w[ ural umbrella urn ultra ],
  'V' => %w[ viking vigilant van vague ],
  'W' => %w[ wagon window wok watch ],
  'X' => %w[ xylophone xray xerox ],
  'Y' => %w[ yonder yodel yarn ],
  'Z' => %w[ zircon zap zip ],

  'a' => %w[ ash ant are alarm ],
  'b' => %w[ bro bond be boxer ],
  'c' => %w[ challenge chart cow chain ],
  'd' => %w[ defy dollar duck drape ],
  'e' => %w[ error expert ear extra ],
  'f' => %w[ failure fan frog frame ],
  'g' => %w[ grid gullible goat ghost ],
  'h' => %w[ honourable ham hill home ],
  'i' => %w[ is irk igloo ice input ],
  'j' => %w[ jerry junk jug jumbo ],
  'k' => %w[ kindness kettle kite knack ],
  'l' => %w[ lamp lecture lion lemon ],
  'm' => %w[ military mettle map mover ],
  'n' => %w[ nausea night nut negative ],
  'o' => %w[ option owl original onion ],
  'p' => %w[ parachute price pig prism ],
  'q' => %w[ quandary quantitative queen quick ],
  'r' => %w[ rock risk rose river ],
  's' => %w[ suffix settle shiver stand ],
  't' => %w[ trip trigger tea truth ],
  'u' => %w[ utopia universe unite usage usher urgent uplift upper ],
  'v' => %w[ vizir verse vase video ],
  'w' => %w[ wonder whale wall wheat ],
  'x' => %w[ xenon xenophobia xmas xebec ],
  'y' => %w[ yellow yank yacht youth ],
  'z' => %w[ zeppelin zebra zilch zippy ],

  '0' => %w[ abacus nil zero not ],
  '1' => %w[ bench one single unity ],
  '2' => %w[ casino two pair double ],
  '3' => %w[ derivative thrice trio ],
  '4' => %w[ energy four quartet quadruple ],
  '5' => %w[ five pentathlon quintet quintuple ],
  '6' => %w[ grumpy geezer hexagon serious ],
  '7' => %w[ hug seven heptagon sever ],
  '8' => %w[ imagination eight octagon ottoman ],
  '9' => %w[ jurist nine nonagon near ],

  '+' => %w[ plus add amass cross ],
  '/' => %w[ slash divide under bar ],
  '=' => %w[ pad dot equal equality ], }

RMAP =
  MAP.inject({}) { |h, (k, v)| v.each { |vv|
    fail "collision for: #{k} / #{vv}" if h[vv] && h[vv] != k
    h[vv] = k }; h }

SEPS =
  [ ' ' ] * 50 +
  [ ', ' ] * 7 +
  [ '. ' ] * 6 +
  [ ' - ' ] * 3 +
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
    s1 = s.downcase.split(/[-.,;:\/ ]+/).inject('') { |ss, e| ss + RMAP[e] }
    File.open("#{path}.#{i}.out", 'wb') do |f|
      f.write(Base64.decode64(s1))
    end
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

