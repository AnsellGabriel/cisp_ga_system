# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# # GEOGRAPHICAL ADDRESS

# spreadsheet = Roo::Spreadsheet.open("./db/uploads/addresses.xlsx")

# (2..spreadsheet.last_row).each do |row|
#     reg = GeoRegion.find_or_initialize_by(name: spreadsheet.cell(row, 'A').strip)
#     puts "#{reg.name}" if reg.save!

#     pro = GeoProvince.find_or_initialize_by(name: spreadsheet.cell(row, 'B').strip)
#     pro.geo_region_id = reg.id
#     puts "#{pro.name}" if pro.save!
    
#     mun = GeoMunicipality.find_or_initialize_by(name: spreadsheet.cell(row, 'C').strip)
#     mun.geo_region_id = reg.id
#     mun.geo_province_id = pro.id
#     puts "#{mun.name}" if mun.save!
    
#     bar = GeoBarangay.find_or_initialize_by(name: spreadsheet.cell(row, 'D').strip)
#     bar.geo_region_id = reg.id
#     bar.geo_province_id = pro.id
#     bar.geo_municipality_id = mun.id
#     # bar.psgc_code = spreadsheet.cell(row, 'E')
#     puts "#{bar.name}" if bar.save!
# end

spreadsheet = Roo::Spreadsheet.open("./db/uploads/50gacoops.xlsx")

(2..spreadsheet.sheet("For Upload").last_row).each do |row|
    coop = Cooperative.find_or_initialize_by(name: spreadsheet.cell(row, 'A'))
    puts "#{coop.name}" if coop.save!
    
    eh = EventHub.find_or_initialize_by(vote_code: spreadsheet.cell(row, 'C'))
    eh.code = spreadsheet.cell(row, 'B')
    eh.coop_event_id = 1
    eh.cooperative_id = coop.id
    eh.capital = 0
    eh.vote_power = 0
    puts "#{eh.vote_code}" if eh.save!
    
end