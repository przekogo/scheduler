class Day < ActiveRecord::Base
  has_many :schedules
  has_many :tasks, through: :schedules

  validates :name, presence: true, uniqueness: true, inclusion: {in: %w[monday tuesday wednesday thursday friday saturday sunday]}
end
