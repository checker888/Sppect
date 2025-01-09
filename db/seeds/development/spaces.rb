idx = 0
# genres = Genre.all
sub =
  "最高のオーナーが運営する最高のスペースはここ \n\n" 
  
  
  
  

%w(owner1 owner2 owner3 owner4 owner5).each do |name|
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
    detail: "OOに適した設備が整っています。",
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
    owner: Owner.find_by!(name: "owner1"),
    genres: genre,
    facilities: facility,
    title: "すごい部屋#{idx2 + 1}",
    subtitle: sub,
    price: 2500,
    capacity: 20,
    available_start_time: Time.zone.local(2025, 1, 9, 10, 0),
    available_end_time: Time.zone.local(2025, 1, 9, 19, 0),
    detail: "OOに適した設備が整っています。",
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
