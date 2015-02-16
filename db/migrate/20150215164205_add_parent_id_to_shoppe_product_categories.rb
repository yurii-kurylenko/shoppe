class AddParentIdToShoppeProductCategories < ActiveRecord::Migration
  def change
    add_column :shoppe_product_categories, :parent_id, :integer
  end
end
