class PagesController < ApplicationController
    def contact_info
        @contact_info = ContactInfo.first
        if @contact_info.nil?
          @contact_info = ContactInfo.new(phone: 'N/A', address: 'N/A', open_hours: 'N/A', email: 'N/A')
        end
      end
    
      def about_info
        @about_info = AboutInfo.first
        if @about_info.nil?
          @about_info = AboutInfo.new(content: 'N/A')
        end
      end
  end