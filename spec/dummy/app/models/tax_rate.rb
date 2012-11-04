class TaxRate < ActiveRecord::Base
  # acts as masterdata
  include ::ERPM::CoreUtils::ActsAsMasterdata::ActiveRecordExtension
  acts_as_masterdata

  # attributes
  attr_accessible :creator_id,
                  :creator_type,
                  :description,
                  :name,
                  :rate,
                  :live_from,
                  :live_to

  # validations
  validates :name, :presence => true
  validates :rate, :presence => true
end

