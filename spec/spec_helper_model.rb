require "spec_helper_unit"

ENV["RAILS_ENV"] ||= "test"

# ActiveRecord
require "yaml"
require "active_record"
conn = YAML.load(File.read(RAILS_ROOT + "config/database.yml"))["test"]
conn["database"] = File.join( RAILS_ROOT, 'db', 'test.sqlite3' )
ActiveRecord::Base.establish_connection(
  conn
)

## Enter database configurations into ActiveRecord
#ActiveRecord::Base.send(:configurations=, YAML::load(ERB.new(IO.read(RAILS_ROOT + "config/database.yml")).result))

# factory_girl
require "factory_girl"
FactoryGirl.find_definitions

# shoulda
require 'shoulda/matchers'

## DatabaseCleaner
#require "database_cleaner"
#RSpec.configure do |config|
#  config.before(:suite) do
#    DatabaseCleaner.strategy = :transaction
#    DatabaseCleaner.clean_with(:truncation)
#  end
#  config.before(:each) do
#    DatabaseCleaner.start
#  end
#  config.after(:each) do
#    DatabaseCleaner.clean
#  end
#end

