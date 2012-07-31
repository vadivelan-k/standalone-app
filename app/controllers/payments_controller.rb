class PaymentsController < ApplicationController
  before_filter :authenticate_user!, :verify_firm!
  
  def index
    @payment ||= Payment.new
    
    @payments = current_firm.all_payments
  end
  
  def create
    matter = Matter.find(params[:payment][:matter_id])
    client = matter.client
    if client.firm_id != current_firm.id
      redirect_to firm_payments_path(current_firm)
      return
    end
    
    @payment = client.payments.build(params[:payment])

    respond_to do |format|
      if @payment.save
        format.html { redirect_to firm_payment_path(current_firm, @payment), notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { index }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  def show
    @payment = Payment.find(params[:id])
    if @payment.client.firm_id != current_firm.id
      redirect_to firm_payments_path(current_firm)
      return
    end
    
    # prepare allocates
    unpaid = @payment.client.invoices.joins("LEFT JOIN payment_allocates ON invoices.id = payment_allocates.invoice_id AND payment_allocates.payment_id = #{@payment.id}").where("invoices.balance > 0 OR payment_allocates.payment_id IS NOT NULL")
    
    @payment_allocates = unpaid.map { |invoice| invoice.payment_allocates.where(:payment_id => @payment.id)[0] || invoice.payment_allocates.build(:payment_id => @payment.id) }
  end

  def update
    @payment = Payment.find(params[:id])
    if @payment.client.firm_id != current_firm.id
      redirect_to firm_payments_path(current_firm)
      return
    end

    # remove unchecked rows from params
    if params[:payment] && params[:payment][:payment_allocates_attributes]
      params[:payment][:payment_allocates_attributes].each do |k, v|
        if v[:allocate_me] != "1"
          # unchecked
          unless v[:id].nil?
            # row in db, delete it
            payment_allocate = PaymentAllocate.find_by_id(v[:id])
            payment_allocate.destroy unless payment_allocate.nil?
          end
          params[:payment][:payment_allocates_attributes].delete k
        end
      end
    end
    
    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to firm_payments_path(current_firm), notice: 'Payment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { redirect_to({ :controller => :payments, :action => :index }, :flash => { :error => @payment.errors.messages.to_s }) }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @payment = Payment.find(params[:id])
    if @payment.client.firm_id != current_firm.id
      redirect_to firm_payments_path(current_firm)
      return
    end
    
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to firm_payments_path(current_firm) }
      format.json { head :ok }
    end
  end
end