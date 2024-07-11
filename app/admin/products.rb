ActiveAdmin.register Product do
  # Specify parameters which should be permitted for assignment
  permit_params :name, :description, :price, :stock_quantity, :image, category_ids: [] 

  # or consider:
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :stock_quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :name
  filter :description
  filter :price
  filter :stock_quantity
  filter :categories, as: :check_boxes, collection: proc { Category.all }
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :categories do |product|
      product.categories.map(&:name).join(", ")
    end
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :name
      row :description
      row :price
      row :stock_quantity
      row :categories do |product|
        product.categories.map(&:name).join(", ")
      end
      row :created_at
      row :updated_at
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "200x200"
        end
      end
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :categories, as: :check_boxes
      f.input :image, as: :file
    end
    f.actions
  end
end
