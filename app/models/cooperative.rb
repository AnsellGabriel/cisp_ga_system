class Cooperative < ApplicationRecord
  validates_presence_of :name
  has_one :event_hub
  belongs_to :geo_region, optional: true
  belongs_to :geo_province, optional: true
  belongs_to :geo_municipality, optional: true
  belongs_to :geo_barangay, optional: true

  def to_s
    name
  end

  CoopType = ["Agrarian Reform Cooperative",
              "Agriculture Cooperative",
              "Consumers Cooperative",
              "Cooperative Bank",
              "Credit Cooperative",
              "Development Cooperative",
              "Electric Cooperative",
              "Employees Cooperative",
              "Farmers Cooperative",
              "Fishermen Cooperative",
              "Marketing Cooperative",
              "Multi-Purpose Cooperative",
              "Others",
              "Producers Cooperative",
              "Savings and Credit",
              "Savings Cooperative",
              "Service Cooperative",
              "Social Cooperative",
              "Transport Cooperative",
              "Worker Cooperative"]
end

def get_address
  geo_province.name + ", " + geo_municipality.name + ", " + geo_barangay.name + ", " +
    # "#{self.street}"
  street
end
