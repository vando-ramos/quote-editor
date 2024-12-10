# puts "\n== Seeding the database with fixtures =="
# system("bin/rails db:fixtures:load")

kmpg = Company.create!(name: 'kmpg')
pwc = Company.create!(name: 'pwc')

User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'manager@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'eavesdropper@pwc.com', password: 'password', company: pwc)

first = Quote.create!(name: 'First quote', company: kmpg)
second = Quote.create!(name: 'Second quote', company: kmpg)
third = Quote.create!(name: 'Third quote', company: kmpg)

LineItemDate.create!(quote: first, date: Date.current)
LineItemDate.create!(quote: first, date: Date.current + 1.week)
