require 'rails_helper'

RSpec.describe LineItemDate, type: :model do
  describe '#valid' do
    it "date can't be blank" do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      lid = LineItemDate.new(date: '', quote: quote)

      expect(lid.valid?).to eq false
    end

    it 'date must be unique' do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      quote = Quote.create!(name: "First quote", company: kmpg)
      LineItemDate.create!(date: Date.current, quote: quote)
      lid = LineItemDate.new(date: Date.current, quote: quote)

      expect(lid.valid?).to eq false
    end
  end

  describe "#previous_date" do
    it "returns the quote's previous date when it exists" do
      kmpg = Company.create!(name: 'KMPG')
      first = Quote.create!(name: "First quote", company: kmpg)
      today = LineItemDate.create!(date: Date.current, quote: first)
      next_week = LineItemDate.create!(date: Date.current + 1.week, quote: first)

      expect(next_week.previous_date).to eq(today)
    end

    it "returns nil when the quote has no previous date" do
      kmpg = Company.create!(name: 'KMPG')
      first = Quote.create!(name: "First quote", company: kmpg)
      today = LineItemDate.create!(date: Date.current, quote: first)
      next_week = LineItemDate.create!(date: Date.current + 1.week, quote: first)

      expect(today.previous_date).to be_nil
    end
  end

  describe 'associations' do
    it { should belong_to(:quote) }
    it { should have_many(:line_items) }
  end
end
