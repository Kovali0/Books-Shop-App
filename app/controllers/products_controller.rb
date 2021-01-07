class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @categories = Category.all
    cate = params[:cate]
    if !cate.nil?
      @products = Product.where(:category_id => cate).decorate
    else
      @products = Product.all.decorate
    end
  end

  def home
    @long_titles = Product.with_long_title
    @order_item = current_order.order_items.new
    @categories = Category.all
    cate = params[:cate]
    if !cate.nil?
      @products = Product.where(:category_id => cate).decorate
    else
      @products = Product.all.decorate
    end #todo repair span-badge frontend
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = @product.decorate
    @comments = @product.comments.all
    @comment = @product.comments.build
  end

  def newest
    @products = Product.order('created_at DESC').decorate
  end

  def toprating
    @products = Product.all.decorate
    @products = @products.sort { |a,b| b.total_rating <=> a.total_rating }
  end
  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    #@price = Price.create(user: @user)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :author, :description, :category_id, :price, :currency)
    end
end
