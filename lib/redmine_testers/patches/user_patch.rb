require_dependency 'user'

module RedmineTesters
  module Patches
    module UserPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          has_many :orders, foreign_key: 'assigned_to'

          def has_access_to_redmine_testers?(kind)
            !(testers_plugin_user_ids & testers_plugin_group_with_access(kind)).blank?
          end

          def testers_plugin_user_ids
            User.current.groups.select('id').collect{|el| el.id.to_s}
          end

          def testers_plugin_group_with_access(group_name)
            (Setting.plugin_redmine_testers[group_name] || []).map(&:to_s)
          end

          def allowed_to_edit_request?
            (Setting.plugin_redmine_testers['editors'] || []).include?(self.id.to_s)
          end
        end
      end

      module InstanceMethods
        # ..
      end
    end
  end
end
