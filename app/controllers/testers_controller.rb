class TestersController < ApplicationController
  unloadable
  before_filter :check_access
  before_filter :get_project, only: [:index]

  def index
    cookies.delete :project_id
  end

  def create
    @order = Order.new(params[:testers])
    @order.created_by = User.current.id
    @order.status = 1 # new
    if @order.save
      flash[:notice] = "Zgłoszenie zostało zapisane. Numer Twojego zgłoszenia to: ##{@order.id}"
    else
      flash[:error] = 'Zgłoszenie nie zostało zapisane.'
    end
    redirect_to testers_path
  end

  private

  def get_project
    @p = Project.find(cookies["project_id"]) if !cookies["project_id"].blank?
  end

  def check_access
    deny_access unless User.current.admin? || User.current.has_access_to_redmine_testers?('senders')
  end

end
