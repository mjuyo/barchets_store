class CustomersController < ApplicationController
    before_action :authenticate_customer!
  
    def show
      @customer = current_customer
      @province = @customer.province
    end
  
    def edit
      @customer = current_customer
    end
  
    def update
      @customer = current_customer
      if @customer.update(customer_params)
        redirect_to @customer, notice: 'Profile was successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def customer_params
      params.require(:customer).permit(:name, :email, :password, :password_confirmation)
    end
  end
  