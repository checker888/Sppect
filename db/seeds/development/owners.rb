names = %w(Owner1 Owner2 Owner3 Owner4 Owner5)
0.upto(4) do |idx|
  Owner.create(
    name: names[idx],
    address: "3-3-#{idx}",
    phonenumber: "0120-666-554#{idx}",
    email: "#{names[idx]}@example.com",
    birthday: "1990-12-01",
    password: "sppect",
    password_confirmation: "sppect"
  )
end


