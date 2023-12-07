# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#adminsという配列にemailとpasswordの情報をハッシュを格納
#配列は[0,1,2,3]
#ハッシュは{ key: "値"}
admins = [
  {email: "admin@example.com", password: "passw@rd"},
]
#admins.each doでadminというブロック変数にadminsの値を順番に代入
#Adminモデルのデータベースから()内の引数で配列化したハッシュのkey: 値を
#find_or_create_byで一致するものがあればそのレコードが取得されて
#一致するものがない場合は、新しいレコードが作成される。
#同じデータががすでにデータベースに存在している場合、
#新たに作成されることなく既存のデータが再利用できる？
#admin[:email]これは何のどの部分？
admins.each do |admin|
  Admin.find_or_create_by(email: admin[:email]) do |a|
    a.password = admin[:password]
  end
end