Redmine::Plugin.register :redmine_testers do
  name 'Redmine Testers plugin'
  author 'Marcin Świątkiewicz'
  description 'This is a plugin for Redmine which helps testers control their jobs.'
  version '0.0.1'
  url 'http://efigence.com'
  author_url 'http://efigence.com'

  menu :top_menu,
    :testers, { controller: 'testers', action: 'index'},
    caption: :label_testers, :after => :search,
    :if => proc { User.current.logged? && User.current.has_access_to_redmine_testers?('senders') }

  menu :top_menu,
    :testers_manage, { controller: 'testers_manage', action: 'index'},
    caption: :label_testers_manage, :after => :search,
    :if => proc { User.current.logged? && User.current.has_access_to_redmine_testers?('managers') }

  settings :default => {
    'managers' => [],
    'senders' => []
  }, :partial => 'settings/redmine_testers_settings'

  ActionDispatch::Callbacks.to_prepare do
    User.send(:include, RedmineTesters::Patches::UserPatch)
  end

end
