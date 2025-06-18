require "rails_helper"

RSpec.describe "Quotes", type: :system do  
  it "creates a new quote" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company_id: kmpg.id)
    
    login_as user
    visit root_path
    click_on "View quotes"
    click_on "New quote"
    fill_in "Name", with: "Capybara quote"
    click_on "Create quote"

    expect(page).to have_content("Quotes")
    expect(page).to have_content("Capybara quote")
  end  

  it "shows a quote" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company_id: kmpg.id)
    quote = Quote.create!(name: "First quote", company_id: kmpg.id)

    login_as user
    visit root_path    
    click_on "View quotes"
    click_on quote.name

    expect(page).to have_content(quote.name)
  end
  
  it "updates a quote" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company_id: kmpg.id)
    Quote.create!(name: "First quote", company_id: kmpg.id)
  
    login_as user
    visit root_path
    click_on "View quotes"
    click_on "Edit"
    fill_in "Name", with: "Updated quote"
    click_on "Update quote"

    expect(page).to have_content("Quotes")
    expect(page).to have_content("Updated quote")
  end

  it "destroys a quote" do
    kmpg = Company.create!(name: 'KMPG')
    user = User.create!(email: 'accountant@kpmg.com', password: 'password', company_id: kmpg.id)
    quote = Quote.create!(name: "First quote", company_id: kmpg.id)
    
    login_as user
    visit root_path
    click_on "View quotes"
    click_on "Delete"

    expect(page).not_to have_content(quote.name)
  end
end