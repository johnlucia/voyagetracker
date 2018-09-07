class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boats

  after_create :associate_boat

  def associate_boat
    users_boat = Boat.find_by_user_key(account_key)
    users_boat.update_attributes(user_id: id)
  end
end
