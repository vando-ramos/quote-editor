require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe "#total_price" do
    it "returns the total price of the line item" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      line_item = LineItem.create!(name: "Room today", quantity: 3, unit_price: 500, line_item_date: lid)

      expect(line_item.total_price).to eq(1500)
    end
  end
end
