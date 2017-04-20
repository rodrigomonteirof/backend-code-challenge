class Distance < ActiveRecord::Base
  validates :kilometers, inclusion: { in: 1..100_000 }
  validates :origin, presence: true
  validates :destination, presence: true

  def self.find_or_create(origin, destination)
    Distance.find_or_create_by(origin: origin, destination: destination)
  end
end
