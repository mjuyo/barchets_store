class ApplicationController < ActionController::Base
    before_action :set_categories, unless: :admin_controller?

    private

    def set_categories
        @categories = Category.all
    end

    def admin_controller?
        self.class < ActiveAdmin::BaseController
    end
end
