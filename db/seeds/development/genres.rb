names = %w(その他 会議室 自習室 マンション カジノ ゲームセンター キャンプ)
0.upto(5) do |idx|
  genre = Genre.new(
    name: names[idx],
  )
  if genre.save
    # puts "Created Genre: #{genre.name}"
  else
    puts "Failed to create Genre: #{genre.errors.full_messages}"
  end
end
