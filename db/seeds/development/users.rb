names = %w(User1 User2 User3 User4 User5)
0.upto(4) do |idx|
  User.create(
    name: names[idx],
    address: "3-3-#{idx}",
    phonenumber: "0120-555-554#{idx}",
    email: "#{names[idx]}@example.com",
    birthday: "1990-12-01",
    password: "sppect",
    password_confirmation: "sppect"
  )
end


