kmpg = Company.create!(name: 'KMPG')
pwc = Company.create!(name: 'PwC')

User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'manager@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'eavesdropper@pwc.com', password: 'password', company: pwc)

quote1 = Quote.create!(name: "First quote", company: kmpg)
quote2 = Quote.create!(name: "Second quote", company: kmpg)
quote3 = Quote.create!(name: "Third quote", company: kmpg)

lid1 = LineItemDate.create!(date: Date.current, quote: quote1)
lid2 = LineItemDate.create!(date: Date.current + 1.week, quote: quote1)

LineItem.create!(name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, 
                 unit_price: 1000, line_item_date: lid1)
LineItem.create!(name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, 
                 unit_price: 25, line_item_date: lid1)
LineItem.create!(name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, 
                 unit_price: 1000, line_item_date: lid2)
LineItem.create!(name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, 
                 unit_price: 25, line_item_date: lid2)
