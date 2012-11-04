module ERPM
  module CoreUtils
    module Generators
      class LocalesGenerator < Rails::Generators::Base
        desc "Copies the locale files to your application"

        source_root File.expand_path('../../../../../../config/locales', __FILE__)
        
        def generate_locales
          copy_file "erpm.core_utils.en.yml", "config/locales/erpm.core_utils.en.yml"
          copy_file "erpm.core_utils.de.yml", "config/locales/erpm.core_utils.de.yml"
        end   
      end
    end
  end
end        
