ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :category_id, :on_sale, :sale_price, :image

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
      f.input :on_sale
      f.input :sale_price
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :category
    column :on_sale
    column :sale_price
    column "Image" do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "50x50"
      else
        "No Image"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :on_sale
      row :sale_price
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image)
        else
          "No Image"
        end
      end
    end
  end

  filter :name
  filter :description
  filter :price
  filter :stock_quantity
  filter :category
  filter :on_sale
  filter :sale_price
end
