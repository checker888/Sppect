names = %w(トイレ Wifiあり 暖房 ユニットバス プロジェクターあり 火気使用可 コンセント)
0.upto(5) do |idx|
  facility = Facility.new(
    name: names[idx],
  )
  if facility.save
    # puts "Created F: #{genre.name}"
  else
    puts "Failed to create Facility: #{facility.errors.full_messages}"
  end
end
