10.times do |n|
  Note.create(title: "title#{n}", body: "body#{n}")
end