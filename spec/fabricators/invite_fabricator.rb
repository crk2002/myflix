Fabricator(:invite) do
  user
  recipient_name {Faker::Name.name}
  recipient_email {Faker::Internet.email}
end