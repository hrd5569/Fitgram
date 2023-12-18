class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #config/initializers/devise.rbではなくAdminとUserモデルに別々で
  #authentication_keys: [:値]を記述することでAdminの場合はemailでuserの場合は
  #nameでログインできるようになる
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]

  # ユーザー検索用のクラスメソッド
  def self.search_for_admin(name)
    if name.present?
      where('name LIKE ?', "%#{name}%")
    else
      all
    end
  end

end