require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe '#valid' do
    it "name can't be blank" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      line_item = LineItem.new(name: "", quantity: 3, unit_price: 500, line_item_date: lid)

      expect(line_item.valid?).to eq false
    end

    it "quantity can't be blank" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      line_item = LineItem.new(name: "Room today", quantity: '', unit_price: 500, line_item_date: lid)

      expect(line_item.valid?).to eq false
    end

    it "unit_price can't be blank" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      line_item = LineItem.new(name: "Room today", quantity: 3, unit_price: '', line_item_date: lid)

      expect(line_item.valid?).to eq false
    end

    it "quantity must be a number" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      line_item = LineItem.new(name: "Room today", quantity: '', unit_price: 500, line_item_date: lid)

      expect(line_item.valid?).to eq false
      expect(line_item.errors[:quantity]).to include("is not a number")
    end

    it "quantity must be an integer number" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      line_item = LineItem.new(name: "Room today", quantity: 1.5, unit_price: 500, line_item_date: lid)

      expect(line_item.valid?).to eq false
      expect(line_item.errors[:quantity]).to include("must be an integer")
    end

    it 'quantity must be greater than 0' do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.create!(date: Date.current, quote: quote)
      line_item = LineItem.new(name: "Room today", quantity: -1, unit_price: 500, line_item_date: lid)

      expect(line_item.valid?).to eq false
      expect(line_item.errors[:quantity]).to include("must be greater than 0")
    end
  end

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

  describe 'associations' do
    it { should belong_to(:line_item_date) }
  end
end
