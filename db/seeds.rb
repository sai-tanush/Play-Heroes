# db/seeds.rb

puts "Seeding sports..."

sports_data = [
  { name: 'Football' },
  { name: 'Basketball' },
  { name: 'Tennis' },
  { name: 'Swimming' },
  { name: 'Badminton' },
  { name: 'Cricket' },
  { name: 'Volleyball' },
  { name: 'Table Tennis' },
  { name: 'Golf' }
]

sports_data.each do |sport_attributes|
  Sport.find_or_create_by!(name: sport_attributes[:name])
end

puts "Sports seeded successfully!"