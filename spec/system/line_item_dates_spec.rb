require 'rails_helper'

RSpec.describe "LineItemDates", type: :system do
  include ActionView::Helpers::NumberHelper
  
  it "creates a new line item date" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    first = Quote.create!(name: "First quote", company: kmpg)
    
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
    first = Quote.create!(name: "First quote", company: kmpg)
    today = LineItemDate.create!(date: Date.current, quote: first)
    next_week = LineItemDate.create!(date: Date.current + 1.week, quote: first)

    login_as user
    visit quotes_path
    click_on "First quote"
    within "##{ActionView::RecordIdentifier.dom_id(today)}" do
      click_on "Edit"
    end
    fill_in "Date", with: (Date.current + 1.day).to_s
    click_on "Update date"

    expect(page).to have_content(I18n.l(Date.current + 1.day, format: :long))
  end

  it "destroys a line item date" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    first = Quote.create!(name: "First quote", company: kmpg)
    today = LineItemDate.create!(date: Date.current, quote: first)
    next_week = LineItemDate.create!(date: Date.current + 1.week, quote: first)

    login_as user
    visit quotes_path
    click_on "First quote"
    within "##{ActionView::RecordIdentifier.dom_id(today)}" do
      click_on "Delete"
    end

    expect(page).not_to have_content(I18n.l(Date.current, format: :long))
    expect(page).to have_content(number_to_currency(first.total_price))
  end
end
