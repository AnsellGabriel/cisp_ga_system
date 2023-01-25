class CoopEvent < ApplicationRecord
    has_many :elect_positions
    def to_s 
        name
    end
end
