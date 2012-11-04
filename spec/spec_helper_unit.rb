require "pathname"
RAILS_ROOT = Pathname.new(File.expand_path("../../spec/dummy", __FILE__))
ENGINE_ROOT = Pathname.new(File.expand_path("../..", __FILE__))

# ActiveSupport
require "active_support"
require "active_support/dependencies"
%w{ extensions forms helpers mailers models presenters scripts }.each do |dir|
  ActiveSupport::Dependencies.autoload_paths <<
    File.join(ENGINE_ROOT, 'app', dir)
  ActiveSupport::Dependencies.autoload_paths <<
    File.join(RAILS_ROOT, 'app', dir)
end

