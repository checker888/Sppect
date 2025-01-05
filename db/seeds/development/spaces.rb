idx = 0
categories = Category.all
sub =
  "今晩は久しぶりに神宮で野球観戦。内野B席の上段に着席。 \n\n" +
  "先発はヤクルトがブキャナン、広島はジョンソン。" +
  "２回裏に中村選手のセーフティスクイズなどでヤクルトが３点を先取。" +
  "そして、８回裏には代打・荒木選手がレフトスタンドへ２号満塁ホームラン。\n\n" +
  "ブキャナン投手の今季初完封を見届けて、気分良く家路に着きました。"

%w(Owner1 Owner2 Owner3 Owner4 Owner5).each do |name|
  owner = Owner.find_by!(name: name)
  # category = categories[idx % categories.size]
  category = categories
  Space.create(
    owner: owner,  # アソシエーションを使用
    categories: category,  # アソシエーションを使用
    title: "スペース#{idx + 1}",
    subtitle: sub,
    price: 2500,
    capacity: 20,
    available_start_time: Time.zone.local(2024, 12, 20, 10, 0),
    available_end_time: Time.zone.local(2024, 12, 20, 19, 0),
    detail: "OOに適した設備が整っています。",
    average: 0,
    approval: true,
    available: idx.even?,
    payment: 1
  )
  idx += 1
end

