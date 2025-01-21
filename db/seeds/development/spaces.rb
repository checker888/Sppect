idx = 0
# genres = Genre.all
sub =
  "〜快適な空間〜 \n\n" 
  
  
  
  

%w(taro Jiro Owner Owner2 Owner3).each do |name|
  owner = Owner.find_by!(name: name)
  genre = Genre.where(id: idx+1)
  facility = Facility.where(id: idx+1)
  space = Space.new(
    owner: owner,
    genres: genre,
    facilities: facility,
    title: "スペース#{idx + 1}",
    subtitle: sub,
    price: 2500,
    capacity: 20,
    available_start_time: Time.zone.local(2025, 1, 1, 10, 0),
    available_end_time: Time.zone.local(2025, 1, 1, 19, 0),
    detail: "最新の設備が整っています。",
    average: 0,
    approval: true,
    available: true,
    payment: 1
  )
  if space.save
    # puts "Created Owner: #{owner.name}"
  else
    puts "Failed to create space: #{space.errors.full_messages}"
  end
  idx += 1
end





0.upto(2) do |idx2|
  genre = Genre.where(id: idx2+1)
  facility = Facility.where(id: [idx2+1,idx2+2])
  space = Space.new(
    owner: Owner.find_by!(name: "taro"),
    genres: genre,
    facilities: facility,
    title: "部屋#{idx2 + 1}",
    subtitle: sub,
    price: 1500,
    capacity: 4,
    available_start_time: Time.zone.local(2025, 1, 9, 10, 0),
    available_end_time: Time.zone.local(2025, 1, 9, 19, 0),
    detail: "まったりくつろげます。",
    average: 0,
    approval: idx2.even?,
    available: idx2.even?,
    payment: 1
  )
  if space.save
    # puts "Created Owner: #{owner.name}"
  else
    puts "Failed to create space: #{space.errors.full_messages}"
  end
end
