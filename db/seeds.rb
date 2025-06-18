kmpg = Company.create!(name: 'KMPG')
pwc = Company.create!(name: 'PwC')

User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'manager@kpmg.com', password: 'password', company: kmpg)
User.create!(email: 'eavesdropper@pwc.com', password: 'password', company: pwc)

first = Quote.create!(name: "First quote", company: kmpg)
second = Quote.create!(name: "Second quote", company: kmpg)
third = Quote.create!(name: "Third quote", company: kmpg)

today = LineItemDate.create!(date: Date.current, quote: first)
next_week = LineItemDate.create!(date: Date.current + 1.week, quote: first)

LineItem.create!(name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, 
                 unit_price: 1000, line_item_date: today)
LineItem.create!(name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, 
                 unit_price: 25, line_item_date: today)
LineItem.create!(name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, 
                 unit_price: 1000, line_item_date: next_week)
LineItem.create!(name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, 
                 unit_price: 25, line_item_date: next_week)
