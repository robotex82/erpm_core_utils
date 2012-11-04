require 'awesome_nested_set'
require 'rails_tools-unchanged_validator'
require 'validates_timeliness'

require 'erpm/core_utils/engine'
require 'erpm/core_utils/configuration'
require 'erpm/core_utils/routing'

require 'erpm/core_utils/acts_as_masterdata/active_record_extension'
require 'erpm/core_utils/acts_as_masterdata/errors'
require 'erpm/core_utils/acts_as_worm/active_record_extension'

module ERPM
  module CoreUtils
    extend Configuration
  end
end
