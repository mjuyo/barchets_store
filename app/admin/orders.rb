ActiveAdmin.register Order do
  permit_params :order_date, :status, :total_price, :total_tax, :address, :province_id

  index do
    selectable_column
    id_column
    column :order_date
    column :status
    column :total_price
    column :total_tax
    column :address
    column :province
    actions
  end

  show do
    attributes_table do
      row :id
      row :order_date
      row :status
      row :total_price
      row :total_tax
      row :address
      row :province
      row("Total Price") { number_to_currency order.total_price }
      row("PST") { number_to_currency((order.province.pst_rate * order.total_price / 100).round(2)) if order.province.pst_rate.present? }
      row("GST") { number_to_currency((order.province.gst_rate * order.total_price / 100).round(2)) if order.province.gst_rate.present? }
      row("HST") { number_to_currency((order.province.hst_rate * order.total_price / 100).round(2)) if order.province.hst_rate.present? }
      row("QST") { number_to_currency((order.province.qst_rate * order.total_price / 100).round(2)) if order.province.qst_rate.present? }
    end
  end

  form do |f|
    f.inputs do
      #f.input :order_date, as: :datepicker
      f.input :status
      f.input :total_price
      f.input :total_tax
      f.input :address
      f.input :province, as: :select, collection: Province.all.collect { |province| [province.name, province.id] }
    end
    f.actions
  end
end
