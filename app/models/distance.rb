class Distance < ActiveRecord::Base
  validates :kilometers, inclusion: { in: 1..100_000 }
  validates :origin, presence: true
  validates :destiny, presence: true
end
