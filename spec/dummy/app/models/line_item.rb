class LineItem < ActiveRecord::Base
  # associations
  belongs_to :tax_rate

  # attributes
  attr_accessible :net_price_cents,
                  :tax_rate

  # validations
  validates :tax_rate, :presence => true
end
