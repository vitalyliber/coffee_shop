module ProductsHelper
  def path_for_form
    if params[:action] == 'new'
      point_products_path(@point)
    elsif params[:action] == 'create'
      point_products_path(@point)
    elsif params[:action] == 'edit'
      point_product_path(@point, @product)
    elsif params[:action] == 'update'
      point_product_path(@point, @product)
    end
  end

  def submit_for_form
    if params[:action] == 'new'
      t(:create_product)
    elsif params[:action] == 'edit'
      t(:save_product)
    end
  end
end
