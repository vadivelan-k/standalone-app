class MattersController < ApplicationController
  before_filter :authenticate_user!, :verify_firm!, :verify_client!
  before_filter :verify_matter!, :except => [:index, :new, :create, :new_form]

  # GET /firms/:firm_id/clients/:client_id/matters
  # GET /firms/:firm_id/clients/:client_id/matters.json
  def index
    @matters = current_client.matters

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matters }
    end
  end

  # GET /firms/:firm_id/clients/:client_id/matters/1
  # GET /firms/:firm_id/clients/:client_id/matters/1.json
  def show
    @matter = current_matter

    @tab = params[:tab] || 'general'

    respond_to do |format|
      format.html { render :show } # show.html.erb
      format.json { render json: @matter }
    end
  end

  # GET /firms/:firm_id/clients/:client_id/matters/new
  # GET /firms/:firm_id/clients/:client_id/matters/new.json
  def new
    @matter = current_client.matters.build

    respond_to do |format|
      format.html { redirect_to new_firm_client_path(current_firm, current_clien)
       } # new.html.erb
      format.json { render json: @matter }
    end
  end

  # GET /firms/:firm_id/clients/:client_id/matters/1/edit
  def edit
    show
  end

  # POST /firms/:firm_id/clients/:client_id/matters
  # POST /firms/:firm_id/clients/:client_id/matters.json
  def create
    @matter = current_client.matters.build(params[:matter])

    respond_to do |format|
      if @matter.save
        format.html { redirect_to firm_client_matter_path(current_firm, current_client, @matter), notice: 'Matter was successfully created.' }
        format.json { render json: @matter, status: :created, location: @matter }
      else
        format.html { redirect_to({ :controller => :clients, :action => :new }, :flash => { :error => @matter.errors.messages.to_s }) }
        format.json { render json: @matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /firms/:firm_id/clients/:client_id/matters/1
  # PUT /firms/:firm_id/clients/:client_id/matters/1.json
  def update
    @matter = current_matter

    respond_to do |format|
      if @matter.update_attributes(params[:matter])
        format.html { redirect_to firm_client_matter_path(current_firm, current_client, @matter), notice: 'Matter was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @matter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firms/:firm_id/clients/:client_id/matters/1
  # DELETE /firms/:firm_id/clients/:client_id/matters/1.json
  def destroy
    @matter = current_matter
    @matter.destroy

    respond_to do |format|
      format.html { redirect_to firm_client_path(current_firm, current_client) }
      format.json { head :ok }
    end
  end
  
  def new_form
    @matter = current_client.matters.build
    render :layout => false
  end
end
