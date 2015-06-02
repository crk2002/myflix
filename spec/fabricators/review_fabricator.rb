Fabricator(:review) do
  user
  video
  rating { 3 }
  content {Faker::Lorem.paragraph(3)}
end