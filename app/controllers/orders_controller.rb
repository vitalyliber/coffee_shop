class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :has_point?

  # GET /orders
  # GET /orders.json
  def index
    @products = Product.all
    @point = Point.find_by(id: params[:point])
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.create(order_params)

    params[:selected_products].each do |product|
      @order.products << Product.find_by_id(product)
    end

    respond_to do |format|
      if @order.save
        format.json { render :show, status: :created, location: @order }
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:title, :cost_price)
    end

    def has_point?
      if params[:point].blank?
        redirect_to root_path
      end
    end
end
