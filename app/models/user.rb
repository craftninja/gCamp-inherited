class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  has_many :memberships
  has_many :projects, through: :memberships

  def full_name
    "#{first_name} #{last_name}"
  end

  def owner?(project)
    self.memberships.where("project_id = ? AND role = ?", project.id, 1).any?
  end

end
