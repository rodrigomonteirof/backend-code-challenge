class Distance < ActiveRecord::Base
  validates :kilometers, inclusion: { in: 1..100_000 }
  validates :origin, presence: true
  validates :destination, presence: true
end
