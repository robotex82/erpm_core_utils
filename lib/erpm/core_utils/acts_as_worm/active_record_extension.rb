module ERPM
  module CoreUtils
    module ActsAsWorm
      module ActiveRecordExtension
        extend ActiveSupport::Concern
        included do
          before_destroy do
            raise ActiveRecord::ReadOnlyRecord
          end
        end

        module ClassMethods
          def acts_as_worm(options = {})
            options.reverse_merge!({ :exclude => [] })

            self.attribute_names.each do |attr|
              unless options[:exclude].map(&:to_s).include?(attr)
                validates(attr.to_sym, :unchanged => true, :if => Proc.new { persisted? })
              end
            end
          end
          
          def delete(*args)
            raise ActiveRecord::ReadOnlyRecord
          end
          
          def delete_all(*args)
            raise ActiveRecord::ReadOnlyRecord
          end
        end

        # instance methods go here
      end
    end
  end
end

