ActiveAdmin.register Order do
  permit_params :order_date, :status, :sub_total_price, :total_price, :total_tax, :address, :province_id

  index do
    selectable_column
    id_column
    column :order_date
    column :status
    column :sub_total_price do |order|
      number_to_currency order.sub_total_price
    end
    column :total_tax do |order|
      number_to_currency order.total_tax
    end
    column :total_price do |order|
      number_to_currency order.total_price 
    end
    column :address
    column :province
    actions
  end

  show do
    attributes_table do
      row :id
      row :order_date
      row :status
      row :address
      row :province
      row :sub_total_price do |order|
        number_to_currency order.sub_total_price
      end      
      row("PST") { number_to_currency((order.province.pst_rate * order.sub_total_price / 100).round(2)) if order.province.pst_rate.present? }
      row("GST") { number_to_currency((order.province.gst_rate * order.sub_total_price / 100).round(2)) if order.province.gst_rate.present? }
      row("HST") { number_to_currency((order.province.hst_rate * order.sub_total_price / 100).round(2)) if order.province.hst_rate.present? }
      row("QST") { number_to_currency((order.province.qst_rate * order.sub_total_price / 100).round(2)) if order.province.qst_rate.present? }
      row :total_tax do |order|
        number_to_currency order.total_tax 
      end
      row :total_price do |order|
        number_to_currency order.total_price
      end
    end

    panel "Order Items" do
      table_for order.order_products do
        column :product
        column :quantity
        column :price do |order_product|
          number_to_currency order_product.price
        end
      end
    end
  end

  form do |f|
    f.inputs do
      #f.input :order_date, as: :datepicker
      f.input :status
      f.input :address
      f.input :province, as: :select, collection: Province.all.collect { |province| [province.name, province.id] }
      f.input :sub_total_price
      f.input :total_tax
      f.input :total_price
    end
    f.actions
  end
end
