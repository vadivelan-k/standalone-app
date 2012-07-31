module ApplicationHelper
  # before filter to verify user belongs to firm_id
  # must run :authenticate_user! (devise filter) before this
  # to ensure user is already signed in
  def verify_firm!
    firm_id = controller_name == 'firms' ? params[:id] : params[:firm_id]
    @current_firm = current_user.firms.where(:id => firm_id).first
    if @current_firm
      add_breadcrumb @current_firm.name, firm_path(@current_firm)
    else
      redirect_to home_path
    end
  end

  def current_firm
    @current_firm # set verify_firm! before filter to populate this instance variable
  end
  
  def verify_client!
    client_id = controller_name == 'clients' ? params[:id] : params[:client_id]
    @current_client = current_firm.clients.where(:id => client_id).first
    if @current_client
      add_breadcrumb @current_client.name, firm_client_path(current_firm, @current_client)
    else
      redirect_to current_firm
    end
  end
  
  def current_client
    @current_client # set verify_firm! and verify_client! before filter to populate this instance variable
  end
  
  def verify_matter!
    matter_id = controller_name == 'matters' ? params[:id] : params[:matter_id]
    @current_matter = current_client.matters.where(:id => matter_id).first
    if @current_matter
      add_breadcrumb @current_matter.name, firm_client_matter_path(current_firm, current_client, @current_matter)
    else
      redirect_to current_client
    end
  end
  
  def current_matter
    @current_matter # set verify_firm! and verify_client! and verify_matter! before filter to populate this instance variable
  end
  
  def verify_task!
    task_id = controller_name == 'tasks' ? params[:id] : params[:task_id]
    @current_task = current_firm.tasks.where(:id => task_id).first
    if @current_task
      add_breadcrumb @current_task.name, firm_task_path(current_firm, @current_task)
    else
      redirect_to current_firm
    end
  end
  
  def current_task
    @current_task # set verify_firm! before filter to populate this instance variable
  end
end
