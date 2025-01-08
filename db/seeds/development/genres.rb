names = %w(会議室 キャンプ 自習室)
0.upto(2) do |idx|
  genre = Genre.new(
    name: names[idx],
  )
  if genre.save
    # puts "Created Genre: #{genre.name}"
  else
    puts "Failed to create Genre: #{genre.errors.full_messages}"
  end
end
