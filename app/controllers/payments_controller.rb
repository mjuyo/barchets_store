class PaymentsController < ApplicationController
    def new
      @order = Order.find(params[:order_id])
    end
  
    def create
      @order = Order.find(params[:order_id])
      token = params[:stripeToken]
  
      begin
        charge = Stripe::Charge.create(
          amount: (@order.total_price * 100).to_i, 
          currency: 'cad',
          source: token,
          description: 'Order payment'
        )
  
        @order.update(status: 'paid', payment_id: charge.id)
        session[:cart] = {}
        redirect_to order_path(@order), notice: 'Payment was successful.'
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_payment_path
      end
    end
  end
  