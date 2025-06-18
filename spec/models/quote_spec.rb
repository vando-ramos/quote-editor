require 'rails_helper'

RSpec.describe Quote, type: :model do
  describe '#valid' do
    it "name can't be blank" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.new(name: "", company: kmpg)
      
      expect(quote.valid?).to eq false
    end
  end

  describe "#total_price" do
    it "returns the sum of the total price of all line items" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      LineItem.create!(name: "Room today", quantity: 3, unit_price: 500, line_item_date: lid)
      LineItem.create!(name: "Catering", quantity: 10, unit_price: 100, line_item_date: lid)

      expect(quote.total_price).to eq(2500)
    end
  end

  describe 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:line_items) }
  end
end
