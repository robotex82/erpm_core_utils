require 'active_support/concern'

module ERPM
  module CoreUtils
    module ActsAsMasterdata
      module ActiveRecordExtension
        extend ActiveSupport::Concern

        included do
        end

        module ClassMethods
          def acts_as_masterdata(options = {})
            options.reverse_merge!({  })

            acts_as_nested_set
            validates :live_from, :presence => true
            validates_datetime :live_from, :after => Proc.new { |obj| obj.parent.live_from }, :if => Proc.new { |obj| obj.parent.present? }

            after_initialize :set_live_to
            before_save :set_live_from_on_parent, :if => Proc.new { parent.present? }
          end

          def live
            live_at(Time.zone.now)
          end

          def live_at(point_in_time = Time.zone.now)
            t = self.arel_table
            scope = where(t[:live_from].lt(point_in_time).or(t[:live_from].eq(nil))).where(t[:live_to].gt(point_in_time).or(t[:live_to].eq(nil)))
#            p scope.to_sql.inspect
            scope
          end
        end

        def dup(*args)
          raise ERPM::CoreUtils::ActsAsMasterdata::DupNotAllowedOnParentRecord if children.present?
          duped = super(*args)
          duped.parent = self
          return duped
        end

        def versions
          root.self_and_descendants
        end

        private

        def set_live_from_on_parent
          parent.live_to = live_from
          parent.save!
        end

        def set_live_to
          if new_record?
            self.live_to ||= DateTime.new(9999, 12, 31)
          end
        end
      end
    end
  end
end

