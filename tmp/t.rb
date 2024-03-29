
a = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + [ '+', '/', '=' ]

a.each do |e|
  puts "'#{e}' => 'nada',"
end

