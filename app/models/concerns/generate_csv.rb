module GenerateCsv
    extend ActiveSupport::Concern 
    require 'csv'
    class_methods do 
        def self.to_csv(collection) 
            CSV.generate(col_sep: ";") do |csv|
              csv << attribute_names
        
              collection.find_each do |record| 
                csv << record.id
              end
            end
        end
    end
end
