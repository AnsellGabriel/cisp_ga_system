module ApplicationHelper
    include Pagy::Frontend
    
    def to_curr(value)
        number_with_delimiter(value.to_i, :delimiter => ',', :precision => 0)
    end
end
