class Project < ActiveRecord::Base
  validates :name, presence: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :tasks, dependent: :destroy

end
