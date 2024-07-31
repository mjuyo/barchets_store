module ProductInfo
    extend Discordrb::Commands::CommandContainer
    Bot.command(:productinfo) do |event, *product_name|
        product_name = product_name.join(" ")
        product = Product.where('LOWER(name) = ?', product_name.downcase).first
        
        if product
            response = "Product Name: #{product.name}\n"
            response += "Description: #{product.description}\n"
            response += "Price: $#{product.price}\n"
            response += "Stock: #{product.stock_quantity} units"
        else
            response = "Product not found."
        end
        event.respond response
    end
end
  