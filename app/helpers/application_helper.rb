module ApplicationHelper
    def breadcrumbs
        crumbs = []
        crumbs << link_to('Home', root_path)
        
        if @product&.categories
          category = @product.categories
          crumbs << link_to(category.name, category_path(category))
          crumbs << @product.name
        end
    
        crumbs.join(' > ').html_safe
      end
end
