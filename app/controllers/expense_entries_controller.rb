class ExpenseEntriesController < ApplicationController
  before_filter :authenticate_user!, :verify_firm!

  # GET /expense_entries
  # GET /expense_entries.json
  def index
    @expense_entry ||= current_user.expense_entries.build(
      :tdate => Date.today
    )
    
    @expense_entries = current_firm.all_expense_entries

    respond_to do |format|
      format.html { render :index }# index.html.erb
      format.json { render json: @expense_entries }
    end
  end

  # GET /expense_entries/1
  # GET /expense_entries/1.json
  def show
    edit
  end

  # GET /expense_entries/new
  # GET /expense_entries/new.json
  def new
    index
  end

  # GET /expense_entries/1/edit
  def edit
    @expense_entry = current_firm.all_expense_entries.find(params[:id])
    index
  end

  # POST /expense_entries
  # POST /expense_entries.json
  def create
    @expense_entry = current_user.expense_entries.build(params[:expense_entry])
    @expense_entry.entry_user_id = current_user.id

    if @expense_entry.invoice_id.nil?
      # create from index page
      respond_to do |format|
        if @expense_entry.save
          format.html { redirect_to firm_expense_entry_path(current_firm, @expense_entry), notice: 'Expense entry was successfully created.' }
          format.json { render json: @expense_entry, status: :created, location: @expense_entry }
        else
          format.html { index }
          format.json { render json: @expense_entry.errors, status: :unprocessable_entity }
        end
      end
    else
      # create from edit invoice page
      respond_to do |format|
        if @expense_entry.save
          format.html { redirect_to edit_firm_invoice_path(current_firm, @expense_entry.invoice_id), notice: 'Expense entry was successfully created.' }
          format.json { render json: @expense_entry, status: :created, location: @expense_entry }
        else
          format.html { new_from_invoice }
          format.json { render json: @expense_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /expense_entries/1
  # PUT /expense_entries/1.json
  def update
    @expense_entry = current_firm.all_expense_entries.find(params[:id])

    respond_to do |format|
      if @expense_entry.update_attributes(params[:expense_entry])
        format.html { redirect_to firm_expense_entry_path(current_firm, @expense_entry), notice: 'Expense entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { index }
        format.json { render json: @expense_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_entries/1
  # DELETE /expense_entries/1.json
  def destroy
    @expense_entry = current_firm.all_expense_entries.find(params[:id])
    @expense_entry.destroy

    respond_to do |format|
      format.html { redirect_to params[:ret] || firm_expense_entries_path(current_firm) }
      format.json { head :ok }
    end
  end

  def hold
    expense_entry = current_firm.all_expense_entries.find(params[:id])
    if expense_entry
      expense_entry.invoice_id = nil
      expense_entry.save!
    end
    redirect_to edit_firm_invoice_path(current_firm, params[:invoice_id])
  end

  # adding expense entry by clicking add button in edit invoice
  def new_from_invoice
    @invoice = Invoice.find(params[:invoice_id] || params[:expense_entry][:invoice_id])
    if @invoice.client.firm_id != current_firm.id
      redirect_to firm_invoices_path(current_firm)
      return
    end
    
    @expense_entry ||= current_user.expense_entries.build(
      :tdate => Date.today,
      :invoice_id => @invoice.id
    )
    render :new_from_invoice
  end
end
