class DiscosController < ApplicationController
  # GET /discos
  # GET /discos.json
  def index
    @discos = Disco.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @discos }
    end
  end

  # GET /discos/1
  # GET /discos/1.json
  def show
    @disco = Disco.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @disco }
    end
  end

  # GET /discos/new
  # GET /discos/new.json
  def new
    @disco = Disco.new

	pista = @disco.pistas.build
		
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @disco }
    end
  end

  # GET /discos/1/edit
  def edit
    @disco = Disco.find(params[:id])
  end

  # POST /discos
  # POST /discos.json
  def create
    @disco = Disco.new(params[:disco])

    respond_to do |format|
      if @disco.save
        format.html { redirect_to @disco, notice: 'Disco was successfully created.' }
        format.json { render json: @disco, status: :created, location: @disco }
      else
        format.html { render action: "new" }
        format.json { render json: @disco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /discos/1
  # PUT /discos/1.json
  def update
    @disco = Disco.find(params[:id])

    respond_to do |format|
      if @disco.update_attributes(params[:disco])
        format.html { redirect_to @disco, notice: 'Disco was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @disco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discos/1
  # DELETE /discos/1.json
  def destroy
    @disco = Disco.find(params[:id])
    @disco.destroy

    respond_to do |format|
      format.html { redirect_to discos_url }
      format.json { head :no_content }
    end
  end
end
