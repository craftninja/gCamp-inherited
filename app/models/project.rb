class Project < ActiveRecord::Base
  validates :name, presence: true

  has_many :memberships
  has_many :users, through: :memberships

  has_many :tasks
end
