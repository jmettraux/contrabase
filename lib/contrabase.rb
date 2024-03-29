#!/usr/bin/env ruby

MAP = {

  'A' => %w[ ask ace apple amber ],
  'B' => %w[ brother bat box broom badge ],
  'C' => %w[ candid charred cat crisp crave ],
  'D' => %w[ desert delicacy dog drake dwell ],
  'E' => %w[ elegy ectoplasm egg exile elbow ],
  'F' => %w[ fried fire fox fable flare ],
  'G' => %w[ goose glib gun grape gloom ],
  'H' => %w[ hubris hawk hat house horse ],
  'I' => %w[ iconoclast icon ink index ivory ],
  'J' => %w[ job jungle jam jolly juice ],
  'K' => %w[ kill korea key kneel knicker kick ],
  'L' => %w[ list larva log latch loyal ],
  'M' => %w[ mole missile mug magic mango ],
  'N' => %w[ north nadir net noble novel ],
  'O' => %w[ obsidian orc obsolete ocean olive ],
  'P' => %w[ paralyse pride pen plead pixel ],
  'Q' => %w[ quartz quantum quill quilt quake ],
  'R' => %w[ rebar rival rat royal roast ],
  'S' => %w[ strict syria sun stalk snack ],
  'T' => %w[ turbine triple top tidal tonic ],
  'U' => %w[ ural umbrella urn ultra urology ],
  'V' => %w[ viking vigilant van vague vexed ],
  'W' => %w[ wagon window wok watch weave ],
  'X' => %w[ xylophone xray xerox ],
  'Y' => %w[ yonder yodel yarn young ],
  'Z' => %w[ zircon zap zip ],

  'a' => %w[ ash ant are alarm angle ],
  'b' => %w[ bro bond be boxer braid ],
  'c' => %w[ challenge chart cow chain chair ],
  'd' => %w[ defy dollar duck drape ],
  'e' => %w[ error expert ear extra ],
  'f' => %w[ failure fan frog frame flock ],
  'g' => %w[ grid gullible goat ghost glass ],
  'h' => %w[ honourable ham hill home honey ],
  'i' => %w[ is irk igloo ice input ideal ],
  'j' => %w[ jerry junk jug jumbo jewel ],
  'k' => %w[ kindness kettle kite knack knead ],
  'l' => %w[ lamp lecture lion lemon lyra ],
  'm' => %w[ military mettle map mover mirth ],
  'n' => %w[ nausea night nut negative niche ],
  'o' => %w[ option owl original onion ornithopter ],
  'p' => %w[ parachute price pig prism plumb ],
  'q' => %w[ quandary quantitative queen quick quiet ],
  'r' => %w[ rock risk rose river racer ],
  's' => %w[ suffix settle shiver stand swine ],
  't' => %w[ trip trigger tea truth torch ],
  'u' => %w[ utopia universe unite usage usher urgent uplift upper usual ],
  'v' => %w[ vizir verse vase video value ],
  'w' => %w[ wonder whale wall wheat wheel ],
  'x' => %w[ xenon xenophobia xmas xebec xylan ],
  'y' => %w[ yellow yank yacht youth yield ],
  'z' => %w[ zeppelin zebra zilch zippy ],

  '0' => %w[ abacus nil zero not null ],
  '1' => %w[ bench one single unity a ],
  '2' => %w[ casino two pair double to ],
  '3' => %w[ derivative thrice trio dry ],
  '4' => %w[ energy four quartet quadruple quadriga ],
  '5' => %w[ five pentathlon quintet quintuple quirinal ],
  '6' => %w[ grumpy geezer hexagon serious sexagenarian ],
  '7' => %w[ hug seven heptagon sever septic ],
  '8' => %w[ imagination eight octagon ottoman auto ],
  '9' => %w[ jurist nine nonagon near numb ],

  '+' => %w[ plus add amass cross ten ],
  '/' => %w[ slash divide under bar ],
  '=' => %w[ pad dot equal equality end ], }

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

