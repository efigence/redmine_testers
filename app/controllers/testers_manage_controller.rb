class TestersManageController < ApplicationController
  unloadable
  before_filter :check_access
  before_filter :set_variables, only: [:show, :update, :edit]

  def index
    if params[:ids]
      @orders = Order.where(id: params[:ids]).eager_load(:project)
    elsif params[:my]
      @orders = User.current.orders.eager_load(:project)
    else
      @orders = Order.eager_load(:project, :user)
    end
    @orders = @orders.order('created_at DESC, priority ASC').paginate(per_page: 15, page: params[:page])
  end

  def show
    render partial: 'show', :layout => false if request.xhr?
  end

  def edit
    render partial: 'edit', :layout => false if request.xhr?
  end

  def update
    if @order.update_attributes(params[:testers])
      @flash = {type: 'notice', msg: 'Zgłoszenie zostało zapisane.'}
    else
      @flash = {type: 'error', msg: 'Zgłoszenie nie zostało zapisane.'}
    end
    render partial: 'show', :layout => false if request.xhr?
  end

  def destroy
    Order.find(params[:id]).destroy
    flash[:notice] = 'Zgłoszenie zostało usunięte.'
    redirect_to testers_panel_path
  end

  private

  def set_variables
    @order = Order.find(params[:id])
    @project = @order.project
  end

  def check_access
    deny_access unless User.current.admin? || User.current.has_access_to_redmine_testers?('managers')
  end

end
