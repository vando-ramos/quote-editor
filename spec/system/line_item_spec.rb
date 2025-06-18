require 'rails_helper'

RSpec.describe "LineItems", type: :system do
  include ActionView::Helpers::NumberHelper  

  it "creates a new line item" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    first = Quote.create!(name: "First quote", company: kmpg)
    today = LineItemDate.create!(date: Date.current, quote: first)
    LineItemDate.create!(date: Date.current + 1.week, quote: first)

    login_as user
    visit quote_path(first)
    within "##{ActionView::RecordIdentifier.dom_id(today)}" do
      click_on "Add item"
    end
    fill_in "Name", with: "Animation"
    fill_in "Quantity", with: 1
    fill_in "Unit price", with: 1234
    click_on "Create item"

    expect(page).to have_content("First quote")
    expect(page).to have_content("Animation")
    expect(page).to have_content(number_to_currency(1234))
  end

  it "updates a line item" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    first = Quote.create!(name: "First quote", company: kmpg)
    today = LineItemDate.create!(date: Date.current, quote: first)
    line_item = LineItem.create!(name: "Room today", quantity: 1, unit_price: 1000, line_item_date: today)
    LineItem.create!(name: 'Meeting room', quantity: 1, unit_price: 1000, line_item_date: today)

    login_as user
    visit quote_path(first)
    within "##{ActionView::RecordIdentifier.dom_id(line_item)}" do
      click_on "Edit"
    end
    fill_in "Name", with: "Capybara article"
    fill_in "Unit price", with: 1234
    click_on "Update item"

    expect(page).to have_content("Capybara article")
    expect(page).to have_content(number_to_currency(1234))
    expect(page).not_to have_content("Room today")
  end

  it "destroys a line item" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
    first = Quote.create!(name: "First quote", company: kmpg)
    today = LineItemDate.create!(date: Date.current, quote: first)
    line_item = LineItem.create!(name: "Room today", quantity: 1, unit_price: 1000, line_item_date: today)
    LineItem.create!(name: 'Meeting room', quantity: 1, unit_price: 1000, line_item_date: today)

    login_as user
    visit quote_path(first)
    within "##{ActionView::RecordIdentifier.dom_id(line_item)}" do
      click_on "Delete"
    end

    expect(page).not_to have_content("Room today")
    expect(page).to have_content("Meeting room")
  end
end
