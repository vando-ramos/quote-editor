kmpg = Company.create!(name: 'KMPG')
pwc = Company.create!(name: 'PwC')

Quote.create!(name: "First quote", company_id: kmpg.id)
Quote.create!(name: "Second quote", company_id: kmpg.id)
Quote.create!(name: "Third quote", company_id: kmpg.id)

User.create!(email: 'accountant@kpmg.com', password: 'password', company_id: kmpg.id)
User.create!(email: 'manager@kpmg.com', password: 'password', company_id: kmpg.id)
User.create!(email: 'eavesdropper@pwc.com', password: 'password', company_id: pwc.id)

