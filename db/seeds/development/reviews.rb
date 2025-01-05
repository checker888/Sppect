idx = 0

%w(User1 User2 User3 User4 User5).each do |name|
  user = User.find_by!(name: name)
  space = Space.find_by!(title: "スペース1")
  # category = categories[idx % categories.size]
  Review.create(
    user: user,  # アソシエーションを使用
    space: space,  # アソシエーションを使用
    comment: "#{idx + 1}番目に素晴らしいスペースでした",
    posted_at:  10.days.ago.advance(days: idx),
    rating: 5-idx
  )
  idx += 1
end