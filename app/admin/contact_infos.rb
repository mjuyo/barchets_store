ActiveAdmin.register ContactInfo do
  menu label: "Contact Info"
  
  # Specify parameters which should be permitted for assignment
  permit_params :phone, :address, :open_hours, :email

  # or consider:
  #
  # permit_params do
  #   permitted = [:phone, :address, :open_hours, :email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :phone
  filter :address
  filter :open_hours
  filter :email
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :phone
    column :address
    column :open_hours
    column :email
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :phone
      row :address
      row :open_hours
      row :email
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :phone
      f.input :address
      f.input :open_hours
      f.input :email
    end
    f.actions
  end
end
