class FirmsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_firm!, :except => [:index, :new, :create]

  # GET /firms
  # GET /firms.json
  def index
    @firms = current_user.firms

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @firms }
    end
  end

  # GET /firms/1
  # GET /firms/1.json
  def show
    redirect_to firm_time_entries_path(current_firm)
=begin    
    @firm = current_firm

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @firm }
    end
=end
  end

  # GET /firms/new
  # GET /firms/new.json
  def new
    @firm = Firm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @firm }
    end
  end

  # GET /firms/1/edit
  def edit
    @firm = current_firm
  end

  # POST /firms
  # POST /firms.json
  def create
    @firm = Firm.new(params[:firm])
    @firm.firm_users.build(:user_id => current_user.id)

    respond_to do |format|
      if @firm.save
        format.html { redirect_to @firm, notice: 'Firm was successfully created.' }
        format.json { render json: @firm, status: :created, location: @firm }
      else
        format.html { render action: "new" }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /firms/1
  # PUT /firms/1.json
  def update
    @firm = current_firm

    respond_to do |format|
      if @firm.update_attributes(params[:firm])
        format.html { redirect_to @firm, notice: 'Firm was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firms/1
  # DELETE /firms/1.json
  def destroy
    @firm = current_firm
    @firm.destroy

    respond_to do |format|
      format.html { redirect_to firms_url }
      format.json { head :ok }
    end
  end
end
