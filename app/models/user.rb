class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #config/initializers/devise.rbではなくAdminとUserモデルに別々で
  #authentication_keys: [:値]を記述することでAdminの場合はemailでuserの場合は
  #nameでログインできるようになる
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  has_many :posts, dependent: :destroy
  
  # TODO: バリデーションで、身長・体重などは必須にする

  def bmi
    self.weight / ((self.height / 100) ** 2)
  end
end
