class ApplicationController < ActionController::Base
    before_action :set_categories, unless: :admin_controller?
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    private
  
    def set_categories
      @categories = Category.all
    end
  
    def admin_controller?
      self.class < ActiveAdmin::BaseController
    end
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :province_id, :phone_number])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :province_id, :phone_number])
    end
  end
  