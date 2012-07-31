class ClientsController < ApplicationController
  before_filter :authenticate_user!, :verify_firm!
  before_filter :verify_client!, :except => [:index, :new, :create]

  # GET /firms/:firm_id/clients
  # GET /firms/:firm_id/clients.json
  def index    
    @clients = current_firm.clients.joins(:matters).includes(:matters)

    if params[:cmfilter]
      @filter_status = params[:cmfilter][:status]
      @filter_cname = params[:cmfilter][:cname]
      @filter_mname = params[:cmfilter][:mname]

      unless @filter_status.blank?
        if @filter_status.to_i == Client.statuses.prospect
          @clients = @clients.where(["clients.status_cd = ?", @filter_status])
        else
          @clients = @clients.where(["clients.status_cd = ? AND matters.status_cd = ?", @filter_status, @filter_status])
        end
      end
      unless @filter_cname.blank?
        @clients = @clients.where(["clients.name LIKE ?", "%#{@filter_cname}%"])
      end
      unless @filter_mname.blank?
        @clients = @clients.where(["matters.name LIKE ?", "%#{@filter_mname}%"])
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /firms/:firm_id/clients/1
  # GET /firms/:firm_id/clients/1.json
  def show
    @client = current_client
    
    @tab = params[:tab] || 'general'

    respond_to do |format|
      format.html { render :show } # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /firms/:firm_id/clients/new
  # GET /firms/:firm_id/clients/new.json
  def new
    @client = current_firm.clients.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /firms/:firm_id/clients/1/edit
  def edit
    show
  end

  # POST /firms/:firm_id/clients
  # POST /firms/:firm_id/clients.json
  def create
    @client = current_firm.clients.build(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to firm_client_path(current_firm, @client), notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /firms/:firm_id/clients/1
  # PUT /firms/:firm_id/clients/1.json
  def update
    @client = current_client

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to firm_client_path(current_firm, @client), notice: 'Client was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firms/:firm_id/clients/1
  # DELETE /firms/:firm_id/clients/1.json
  def destroy
    @client = current_client
    @client.destroy

    respond_to do |format|
      format.html { redirect_to current_firm }
      format.json { head :ok }
    end
  end
end
