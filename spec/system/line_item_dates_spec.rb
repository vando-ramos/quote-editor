require 'rails_helper'

RSpec.describe "LineItemDates", type: :system do
  include ActionView::Helpers::NumberHelper
  
  it "creates a new line item date" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    Quote.create!(name: "First quote", company: kmpg)
    
    login_as user
    visit quotes_path
    click_on "First quote"
    click_on "New date"
    fill_in "Date", with: (Date.current + 1.day).to_s
    click_on "Create date"

    expect(page).to have_content(I18n.l(Date.current + 1.day, format: :long))
  end

  it "updates a line item date" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    quote = Quote.create!(name: "First quote", company: kmpg)
    lid = LineItemDate.create!(date: Date.current, quote: quote)
    LineItemDate.create!(date: Date.current + 1.week, quote: quote)

    login_as user
    visit quotes_path
    click_on "First quote"
    within "##{ActionView::RecordIdentifier.dom_id(lid)}" do
      click_on "Edit"
    end
    fill_in "Date", with: (Date.current + 1.day).to_s
    click_on "Update date"

    expect(page).to have_content(I18n.l(Date.current + 1.day, format: :long))
  end

  it "destroys a line item date" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    quote = Quote.create!(name: "First quote", company: kmpg)
    lid = LineItemDate.create!(date: Date.current, quote: quote)
    LineItemDate.create!(date: Date.current + 1.week, quote: quote)

    login_as user
    visit quotes_path
    click_on "First quote"
    within "##{ActionView::RecordIdentifier.dom_id(lid)}" do
      click_on "Delete"
    end

    expect(page).not_to have_content(I18n.l(Date.current, format: :long))
    expect(page).to have_content(number_to_currency(quote.total_price))
  end
end
