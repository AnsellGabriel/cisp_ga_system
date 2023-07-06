module ApplicationHelper
    include Pagy::Frontend
    
    def to_curr(value)
        if value.present?
            number_with_delimiter(value, :delimiter => ',', :precision => 2) 
        end
    end
end
