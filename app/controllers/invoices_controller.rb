class InvoicesController < ApplicationController
  before_filter :authenticate_user!, :verify_firm!

  def index
    # for create invoices
    @cd_from = params[:filters] && !params[:filters][:cd_from].blank? ? params[:filters][:cd_from] : 'earliest'
    @cd_from = @cd_from.to_date unless @cd_from == 'earliest'
    @cd_to = params[:filters] && !params[:filters][:cd_to].blank? ? params[:filters][:cd_to].to_date : Date.today
    @cd_date = params[:filters] && !params[:filters][:cd_date].blank? ? params[:filters][:cd_date].to_date : Date.today

    @selected_client_ids = params[:client_ids] || [""]

    @faction = params[:faction] || 'view_draft'
    
    if @faction == 'create_draft'
      Invoice.create_new current_firm, @cd_from, @cd_to, @cd_date, @selected_client_ids
      @faction = 'view_draft'
      @vi_from = @cd_from == 'earliest' ? 1.year.ago : @cd_from
      @vi_to = @cd_to
    end
    
    case @faction
    when 'create_statement'
      raise 'redirect to create statement'
    when 'view_sent'
      @vtype_text = "Sent Invoices"
      @invoices = current_firm.all_invoices.sent    
    else # when 'view_draft'
      @vtype_text = "Draft Invoices"
      @invoices = current_firm.all_invoices.draft
    end
        
    @vi_from ||= params[:filters] && !params[:filters][:vi_from].blank? ? params[:filters][:vi_from].to_date : 60.days.ago.to_date
    @vi_to ||= params[:filters] && !params[:filters][:vi_to].blank? ? params[:filters][:vi_to].to_date : Date.today
        
    @invoices = @invoices.where(["tdate >= ? AND tdate < ?", @vi_from, @vi_to + 1.day])    
  end
  
  def new
    @client = Client.find(params[:client_id])
    if @client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end
        
    @matter_summaries = @client.unbilled_matters
    
    consolidated = current_firm.unbilled_summary
    @all_summary = consolidated[@client.id]
  end
=begin
  # POST /firms/:firm_id/invoices
  # POST /firms/:firm_id/invoices.json
  def create
    client = Client.find(params[:client_id])
    if client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end
      
    invoice = client.invoices.build(
      :tdate => Date.today,
      :period_start => params[:period_start].to_date,
      :period_end => params[:period_end].to_date,
      :term_id => 0
    )
    
    matters = params[:matters]
    
    matters.each do |matter_id|
      matter = Matter.find(matter_id)
      invoice.time_entries << matter.unbilled_time_entries(invoice.period_start, invoice.period_end)
      invoice.expense_entries << matter.unbilled_expense_entries(invoice.period_start, invoice.period_end)
    end
    
    invoice.save!
    
    redirect_to firm_invoice_path(current_firm, invoice.id)
  end
=end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end
    
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to firm_invoices_path(current_firm) }
      format.json { head :ok }
    end
  end
  
  def show
    @invoice = Invoice.find(params[:id])
    if @invoice.client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end
  end
  
  def edit
    @invoice = Invoice.find(params[:id])
    if @invoice.client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to edit_firm_invoice_path(current_firm, @invoice), notice: 'Invoice was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
end
