require 'rails_helper'

RSpec.describe LineItemDate, type: :model do
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
end
