class Order < ActiveRecord::Base
  unloadable
  attr_accessible :project_id, :project_duration_time, :persons, :details, :devices, :workflow, :additional_information, :priority,
                  :estimated_time, :assigned_to, :comment, :status
  belongs_to :project
  belongs_to :user, foreign_key: 'assigned_to'
  serialize :persons, Hash
  serialize :details, Hash
  serialize :devices, Hash
  
  after_create :notify_subscribers

  PRIORITIES = {
    1 => 'HIGH',
    2 => 'NORMAL',
    3 => 'LOW'
  }

  STATUSES = {
    1 => I18n.t('label_statuses.new'),
    2 => I18n.t('label_statuses.in_progress'),
    3 => I18n.t('label_statuses.resolved'),
    4 => I18n.t('label_statuses.closed'),
    5 => I18n.t('label_statuses.on_hold'),
    6 => I18n.t('label_statuses.wrong')
  }

  private

  def notify_subscribers
    subscribers = User.find(Setting.plugin_redmine_testers['notifiers'])
    if subscribers.any?
      subscribers.each { |s| send_notification(s) }
    end
  end

  def send_notification user
    n = Notification.new
    n.notifiable_id = self.id
    n.notifiable_type = 'Order'
    n.planning_send_at = DateTime.now + 1.minute
    n.to = user.mail
    n.kind = :mail
    n.user_id = user.id
    n.subject = I18n.t('subject_new_order')
    url = Rails.application.routes.url_helpers.testers_panel_url(host: 'https://secure.artegence.com/redmine') + "?ids=#{self.id}"
    n.content = I18n.t('content_new_order', project: self.project.name, page: url, identifier: self.id )
    n.save
  end

end
