module ERPM
  module CoreUtils
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Generates the intializer"

        source_root File.expand_path('../templates', __FILE__) 
        
        def generate_intializer
          copy_file "erpm_core_utils.rb", "config/initializers/erpm_core_utils.rb"
        end   
      end
    end
  end
end        
