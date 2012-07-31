class TimeEntriesController < ApplicationController
  before_filter :authenticate_user!, :verify_firm!

  # GET /time_entries
  # GET /time_entries.json
  def index
    @time_entry ||= current_user.time_entries.build(
      :tdate => Date.today
    )
    
    @time_entries = current_firm.all_time_entries

    respond_to do |format|
      format.html { render :index }# index.html.erb
      format.json { render json: @time_entries }
    end
  end

  # GET /time_entries/1
  # GET /time_entries/1.json
  def show
    edit
  end

  # GET /time_entries/new
  # GET /time_entries/new.json
  def new
    index
  end

  # GET /time_entries/1/edit
  def edit
    @time_entry = current_firm.all_time_entries.find(params[:id])
    index
  end

  # POST /time_entries
  # POST /time_entries.json
  def create
    @time_entry = current_user.time_entries.build(params[:time_entry])
    @time_entry.entry_user_id = current_user.id

    if @time_entry.invoice_id.nil?
      # create from index page
      respond_to do |format|
        if @time_entry.save
          format.html { redirect_to firm_time_entry_path(current_firm, @time_entry), notice: 'Time entry was successfully created.' }
          format.json { render json: @time_entry, status: :created, location: @time_entry }
        else
          format.html { index }
          format.json { render json: @time_entry.errors, status: :unprocessable_entity }
        end
      end
    else
      # create from edit invoice page
      respond_to do |format|
        if @time_entry.save
          format.html { redirect_to edit_firm_invoice_path(current_firm, @time_entry.invoice_id), notice: 'Time entry was successfully created.' }
          format.json { render json: @time_entry, status: :created, location: @time_entry }
        else
          format.html { new_from_invoice }
          format.json { render json: @time_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /time_entries/1
  # PUT /time_entries/1.json
  def update
    @time_entry = current_firm.all_time_entries.find(params[:id])

    respond_to do |format|
      if @time_entry.update_attributes(params[:time_entry])
        format.html { redirect_to firm_time_entry_path(current_firm, @time_entry), notice: 'Time entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { index }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_entries/1
  # DELETE /time_entries/1.json
  def destroy
    @time_entry = current_firm.all_time_entries.find(params[:id])
    @time_entry.destroy

    respond_to do |format|
      format.html { redirect_to params[:ret] || firm_time_entries_path(current_firm) }
      format.json { head :ok }
    end
  end
  
  def hold
    time_entry = current_firm.all_time_entries.find(params[:id])
    if time_entry
      time_entry.invoice_id = nil
      time_entry.save!
    end
    redirect_to edit_firm_invoice_path(current_firm, params[:invoice_id])
  end
  
  # adding a time entry by clicking add button in edit invoice
  def new_from_invoice
    @invoice = Invoice.find(params[:invoice_id] || params[:time_entry][:invoice_id])
    if @invoice.client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end
    
    @time_entry ||= current_user.time_entries.build(
      :tdate => Date.today,
      :invoice_id => @invoice.id
    )
    render :new_from_invoice
  end
end
