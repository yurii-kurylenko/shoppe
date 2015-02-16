module Shoppe
  class ProductCategoriesController < Shoppe::ApplicationController

    before_filter { @active_nav = :product_categories }
    before_filter { params[:id] && @product_category = Shoppe::ProductCategory.find(params[:id]) }

    def index
      @product_categories = Shoppe::ProductCategory.ordered.all
    end

    def new
      @product_category = Shoppe::ProductCategory.new
      @parent_categories = Shoppe::ProductCategory.root
    end

    def create
      @product_category = Shoppe::ProductCategory.new(safe_params)
      if @product_category.save
        redirect_to :product_categories, :flash => { :notice => t('shoppe.product_category.create_notice') }
      else
        render :action => "new"
      end
    end

    def edit
    end

    def update
      if @product_category.update(safe_params)
        redirect_to [:edit, @product_category], :flash => { :notice => t('shoppe.product_category.update_notice') }
      else
        render :action => "edit"
      end
    end

    def destroy
      @product_category.destroy
      redirect_to :product_categories, :flash => { :notice => t('shoppe.product_category.destroy_notice') }
    end

    private

    def safe_params
      params[:product_category].permit(:name, :permalink, :description, :image_file, :parent_id)
    end

  end
end
