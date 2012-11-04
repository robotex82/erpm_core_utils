require 'erpm/core_utils/acts_as_worm/active_record_extension'
require 'rails_tools-unchanged_validator'

class Post < ActiveRecord::Base
  # acts as worm
  include ::ERPM::CoreUtils::ActsAsWorm::ActiveRecordExtension
  acts_as_worm :exclude => [ :body ]

  # attributes
  attr_accessible :body,
                  :title

  # validations
  validates :title, :presence => true
end

