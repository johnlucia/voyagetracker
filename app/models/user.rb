class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boats

  validates :email, uniqueness: true
  validate  :new_user_has_valid_account_key, :on => :create

  after_create :associate_boat

  def associate_boat
    users_boat = Boat.find_by_user_key(account_key)
    users_boat.update_attributes(user_id: id)
  end

  def new_user_has_valid_account_key
    users_boat = Boat.find_by_user_key(account_key)
    unless !account_key.blank? && users_boat
      errors.add(:account_key, "is not valid")
    end
  end
end
