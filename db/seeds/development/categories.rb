genre = ["キャンプ", "BBQ", "会議室", "広場", "公園", "ホテル"]
facility = ["設備1", "設備2", "設備3", "設備4", "設備5", "設備6"]
0.upto(5) do |idx|
  Category.create(
    genre: genre[idx],
    facility: facility[idx]
  )
end



