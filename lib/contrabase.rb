#!/usr/bin/env ruby

MAP = {

  'A' => %w[ ask ace apple ],
  'B' => %w[ brother bat box ],
  'C' => %w[ candid charred cat ],
  'D' => %w[ desert delicacy dog ],
  'E' => %w[ elegy ectoplasm egg ],
  'F' => %w[ fried fire fox ],
  'G' => %w[ goose glib gun ],
  'H' => %w[ hubris hawk hat ],
  'I' => %w[ iconoclast icon ink ],
  'J' => %w[ job jungle jam ],
  'K' => %w[ kill korea key ],
  'L' => %w[ list larva log ],
  'M' => %w[ mole missile mug ],
  'N' => %w[ north nadir net ],
  'O' => %w[ obsidian orc obsolete ],
  'P' => %w[ paralyse pride pen ],
  'Q' => %w[ quartz quantum quill ],
  'R' => %w[ rebar rival rat ],
  'S' => %w[ strict syria sun ],
  'T' => %w[ turbine triple top ],
  'U' => %w[ ural umbrella urn ],
  'V' => %w[ viking vigilant van ],
  'W' => %w[ wagon window wok ],
  'X' => %w[ xylophone xray ],
  'Y' => %w[ yonder yodel yarn ],
  'Z' => %w[ zircon zap zip ],

  'a' => %w[ ash ant are ],
  'b' => %w[ bro bond be ],
  'c' => %w[ challenge chart cow ],
  'd' => %w[ defy dollar duck ],
  'e' => %w[ error expert ear ],
  'f' => %w[ failure fan frog ],
  'g' => %w[ grid gullible goat ],
  'h' => %w[ honourable ham hill ],
  'i' => %w[ is irk igloo ice ],
  'j' => %w[ jerry junk jug ],
  'k' => %w[ kindness kettle kite ],
  'l' => %w[ lamp lecture lion ],
  'm' => %w[ military mettle map ],
  'n' => %w[ nausea night nut ],
  'o' => %w[ option owl original ],
  'p' => %w[ parachute price pig ],
  'q' => %w[ quandary quantitative queen ],
  'r' => %w[ rock risk rose ],
  's' => %w[ suffix settle shiver ],
  't' => %w[ trip trigger tea ],
  'u' => %w[ utopia universe unite usage usher urgent uplift ],
  'v' => %w[ vizir verse vase ],
  'w' => %w[ wonder whale wall ],
  'x' => %w[ xenon xenophobia xmas ],
  'y' => %w[ yellow yank yacht ],
  'z' => %w[ zeppelin zebra zilch ],

  '0' => %w[ abacus nil zero ],
  '1' => %w[ bench one single ],
  '2' => %w[ casino two pair ],
  '3' => %w[ derivative thrice trio ],
  '4' => %w[ energy four quartet ],
  '5' => %w[ five pentathlon quintet ],
  '6' => %w[ grumpy geezer hexagon ],
  '7' => %w[ hug seven heptagon ],
  '8' => %w[ imagination eight octagon ],
  '9' => %w[ jurist nine nonagon ],

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

