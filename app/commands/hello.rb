module Hello
    extend Discordrb::Commands::CommandContainer

    Bot.message(content: 'Hello there!') do |event|
        event.respond 'Obi-Wan Kenobi, the negotiator!'
    end

    Bot.command(:last_product) do |event|
        latest_product = Product.order(created_at: :desc).first
        if latest_product
          event.respond "The latest product is: #{latest_product.name} - #{latest_product.description} - $#{latest_product.price}"
        else
          event.respond "No products found."
        end
    end
end