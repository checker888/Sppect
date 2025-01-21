names = %w(taro Jiro Owner Owner2 Owner3)
0.upto(4) do |idx|
  owner = Owner.new(
    name: names[idx],
    address: "3-3-#{idx}",
    phonenumber: "0120-666-554#{idx}",
    email: "#{names[idx]}@example.com",
    birthday: "1990-12-01",
    password: "sppect!",
    password_confirmation: "sppect!"
  )
  if owner.save
    # puts "Created Owner: #{owner.name}"
  else
    puts "Failed to create Owner: #{owner.errors.full_messages}"
  end
end


