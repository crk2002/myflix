# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Dir.foreach('public/tmp/') do |item|
  next if item == '.' or item == '..'
  Video.create(title: File.basename(item, '.jpg').titleize, description: 'A really great television show', small_cover_url: item, category_id: rand(Category.count)+1)
end