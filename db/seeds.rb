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

# spreadsheet = Roo::Spreadsheet.open("./db/uploads/3rd_octs_ga_coop.xlsx")

# (2..spreadsheet.sheet("Sheet1").last_row).each do |row|
#     coop = Cooperative.find_or_initialize_by(name: spreadsheet.cell(row, 'A'))
#     puts "#{coop.name}" if coop.save!
    
#     eh = EventHub.find_or_initialize_by(vote_code: spreadsheet.cell(row, 'C'))
#     eh.code = spreadsheet.cell(row, 'B')
#     eh.coop_event_id = 1
#     eh.cooperative_id = coop.id
#     eh.capital = 0
#     eh.vote_power = 0
#     puts "#{eh.vote_code}" if eh.save!
# end

spreadsheet = Roo::Spreadsheet.open("./db/uploads/3rd_octs_ga_coop.xlsx")

(2..spreadsheet.sheet("Sheet2").last_row).each do |row|
    coop = Cooperative.find_by(name: spreadsheet.cell(row, 'A'))
    # puts "#{coop.name}" if coop.save!
    
    eh = EventHub.find_by(cooperative: coop)
    eh.vote_power = spreadsheet.cell(row, 'B')
    puts "#{coop.name} - #{eh.vote_power}" if eh.save!
end

# spreadsheet = Roo::Spreadsheet.open("./db/uploads/vote_power_50.xlsx")

# (2..spreadsheet.sheet("Sheet1").last_row).each do |row|
#     coop = Cooperative.find_by(name: spreadsheet.cell(row, 'A'))
#     # puts "NEW COOP -------------------------> #{coop.name}" if coop.save!
#     puts "#{coop.name}"
#     if coop.nil? 
#         puts "Invalid Cooperative " & spreadsheet.cell(row, 'A')
#     else
#         eh = EventHub.find_or_initialize_by(cooperative_id: coop.id)
#         eh.capital = spreadsheet.cell(row, 'B')
#         eh.vote_power = spreadsheet.cell(row, 'C')
#         eh.coop_event_id = 1
#         eh.cooperative_id = coop.id
#         eh.voted = 0
#         eh.attend = 0
#         unless EventHub.exists?(cooperative_id: coop.id)
#             loop do
#                     code = SecureRandom.alphanumeric(4).upcase
#                     modified_string = code.gsub(/[1iO0I]/, "A")
#                     if EventHub.exists?(vote_code: modified_string)
#                         puts "Code #{modified_string} already exists, generating new code..."
#                     else
#                         eh.vote_code = modified_string    
#                     break
#                     end
#             end
#         end
#         puts "#{coop.name} - #{eh.vote_code}" if eh.save!
#     end
    

# COOP TECH IMPORT
# spreadsheet = Roo::Spreadsheet.open("./db/uploads/cooptechreg.xlsx")

# (2..spreadsheet.sheet("Sheet1").last_row).each do |row|
#     coop = Cooperative.find_or_initialize_by(name: spreadsheet.cell(row, 'A'))
#     puts "#{coop.name}" 
#     eh = EventHub.find_by(cooperative_id: coop.id)
    
#     reg = Registration.find_or_initialize_by(event_hub_id:  eh.id, last_name: spreadsheet.cell(row, 'H'))
#     reg.last_name = spreadsheet.cell(row, 'H')
#     reg.first_name = spreadsheet.cell(row, 'I')
#     reg.middle_name = ""
#     reg.email = spreadsheet.cell(row, 'D')
#     reg.mobile_number = spreadsheet.cell(row, 'E')
#     reg.guest_type = spreadsheet.cell(row, 'F')
#     reg.attendance = spreadsheet.cell(row, 'G')
#     if reg.save
#         puts "----Reg--#{reg.last_name}, #{reg.first_name}" 
#         # RegisterMailer.with(registration: reg, event_hub: eh).register_created.deliver_later
#     end
    
