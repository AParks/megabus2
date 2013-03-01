class Trip < ActiveRecord::Base
  attr_accessible :number_of_passengers, :leaving_from, :leaving_from_id, :traveling_to, :traveling_to_id, :outbound_date, :return_date, :total_price

  belongs_to :leaving_from, :class_name => "City"
  belongs_to :traveling_to, :class_name => "City"

  has_many :buses
  validates_date :outbound_date, :on => :create, :on_or_after => :today
  validates_date :outbound_date, :on => :create, :on_or_before => :return_date

  validates :number_of_passengers, presence: true
  validate :cannot_have_same_start_end
  def cannot_have_same_start_end
    if self.leaving_from_id == self.traveling_to_id
      errors.add(:leaving_from, "You cannot have the same start and end city." )
      errors.add(:traveling_to, "" )
    end
  end



end
