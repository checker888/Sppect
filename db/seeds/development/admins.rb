names = %w(Senshu Admin2 Admin3 Admin4 Admin5)
0.upto(4) do |idx|
  Admin.create(
    name: names[idx],
    password: "sppect",
    password_confirmation: "sppect"
  )
end