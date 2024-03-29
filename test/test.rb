
RUBY = 'ruby'

system("#{RUBY} lib/contrabase.rb tmp/text0.txt > tmp/out0.txt")
system("#{RUBY} lib/contrabase.rb -d tmp/out0.txt")
diff = `diff tmp/text0.txt tmp/out0.txt.0.out`.strip

if diff == ''
  puts 'Success.'
else
  puts diff
end

