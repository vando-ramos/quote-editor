kmpg = Company.create!(name: 'KMPG')
pwc = Company.create!(name: 'PwC')

User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'manager@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'eavesdropper@pwc.com', password: 'password', company: pwc)

first = Quote.create!(name: "First quote", company: kmpg)
second = Quote.create!(name: "Second quote", company: kmpg)
third = Quote.create!(name: "Third quote", company: kmpg)

LineItemDate.create!(date: Date.current,quote: first)
LineItemDate.create!(date: Date.current + 1.week,quote: first)
