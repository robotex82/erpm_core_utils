# Raised when trying to dup an object, that already has a child object.
module ERPM
  module CoreUtils
    module ActsAsMasterdata
      class DupNotAllowedOnParentRecord < StandardError
      end
    end
  end
end
