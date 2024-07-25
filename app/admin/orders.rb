ActiveAdmin.register Order do
    index do
      selectable_column
      id_column
      column :customer
      column :order_date
      column :total_price
      column :status
      actions
    end
  
    show do
      attributes_table do
        row :id
        row :customer
        row :order_date
        row :address
        row :province
        row :total_price
        row :total_tax
        row :status
      end
  
      panel "Order Details" do
        table_for order.order_products do
          column :product
          column :quantity
          column :price
          column :total do |order_product|
            number_to_currency(order_product.price * order_product.quantity)
          end
        end
      end
  
      panel "Pricing Summary" do
        attributes_table_for order do
            row("Total Price") { number_to_currency order.total_price }
            row("PST") { number_to_currency(order.province.pst_rate * order.total_price / 100) }
            row("GST") { number_to_currency(order.province.gst_rate * order.total_price / 100) }
            row("HST") { number_to_currency(order.province.hst_rate * order.total_price / 100) }
            row("QST") { number_to_currency(order.province.qst_rate * order.total_price / 100) }
            row("Total Tax") { number_to_currency order.total_tax }
            row("Grand Total") { number_to_currency(order.total_price + order.total_tax) }    
        end
      end
    end
  
    filter :customer
    filter :order_date
    filter :total_price
    filter :status
  
    form do |f|
      f.inputs "Order Details" do
        f.input :customer
        f.input :order_date
        f.input :address
        f.input :province
        f.input :total_price
        f.input :total_tax
        f.input :status
      end
      f.actions
    end
  end
  