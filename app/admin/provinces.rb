ActiveAdmin.register Province do
  # Specify parameters which should be permitted for assignment
  permit_params :name, :pst_rate, :hst_rate, :gst_rate, :qst_rate

  # or consider:
  #
  # permit_params do
  #   permitted = [:name, :pst_rate, :hst_rate, :gst_rate, :qst_rate]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :name
  filter :pst_rate
  filter :hst_rate
  filter :gst_rate
  filter :qst_rate
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :name
    column :pst_rate
    column :hst_rate
    column :gst_rate
    column :qst_rate
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :name
      row :pst_rate
      row :hst_rate
      row :gst_rate
      row :qst_rate
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :name
      f.input :pst_rate
      f.input :hst_rate
      f.input :gst_rate
      f.input :qst_rate
    end
    f.actions
  end
end
