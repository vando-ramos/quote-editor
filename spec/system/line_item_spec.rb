require 'rails_helper'

RSpec.describe "LineItems", type: :system do
  include ActionView::Helpers::NumberHelper  

  it "creates a new line item" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    quote = Quote.create!(name: "First quote", company: kmpg)
    lid = LineItemDate.create!(date: Date.current, quote: quote)
    LineItemDate.create!(date: Date.current + 1.week, quote: quote)

    login_as user
    visit quote_path(quote)
    within "##{ActionView::RecordIdentifier.dom_id(lid)}" do
      click_on "Add item"
    end
    fill_in "Name", with: "Animation"
    fill_in "Quantity", with: 1
    fill_in "Unit price", with: 1234
    click_on "Create item"

    expect(page).to have_content("First quote")
    expect(page).to have_content("Animation")
    expect(page).to have_content(number_to_currency(1234))
    expect(page).to have_content(number_to_currency(quote.total_price))
  end

  it "updates a line item" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    quote = Quote.create!(name: "First quote", company: kmpg)
    lid = LineItemDate.create!(date: Date.current, quote: quote)
    line_item = LineItem.create!(name: "Room today", quantity: 1, unit_price: 1000, line_item_date: lid)
    LineItem.create!(name: 'Meeting room', quantity: 1, unit_price: 1000, line_item_date: lid)

    login_as user
    visit quote_path(quote)
    within "##{ActionView::RecordIdentifier.dom_id(line_item)}" do
      click_on "Edit"
    end
    fill_in "Name", with: "Capybara article"
    fill_in "Unit price", with: 1234
    click_on "Update item"

    expect(page).to have_content("Capybara article")
    expect(page).to have_content(number_to_currency(1234))
    expect(page).to have_content(number_to_currency(quote.total_price))
    expect(page).not_to have_content("Room today")
  end

  it "destroys a line item" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    quote = Quote.create!(name: "First quote", company: kmpg)
    lid = LineItemDate.create!(date: Date.current, quote: quote)
    line_item = LineItem.create!(name: "Room today", quantity: 1, unit_price: 1000, line_item_date: lid)
    LineItem.create!(name: 'Meeting room', quantity: 1, unit_price: 1000, line_item_date: lid)

    login_as user
    visit quote_path(quote)
    within "##{ActionView::RecordIdentifier.dom_id(line_item)}" do
      click_on "Delete"
    end

    expect(page).not_to have_content("Room today")
    expect(page).to have_content("Meeting room")
    expect(page).to have_content(number_to_currency(quote.total_price))
  end
end
