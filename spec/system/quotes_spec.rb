require "rails_helper"

RSpec.describe "Quotes", type: :system do
  it "creates a new quote" do
    visit quotes_path
    expect(page).to have_content("Quotes")

    click_on "New quote"
    expect(page).to have_content("New quote")

    fill_in "Name", with: "Capybara quote"
    click_on "Create quote"

    expect(page).to have_content("Quotes")
    expect(page).to have_content("Capybara quote")
  end

  let!(:quote) { Quote.create!(name: "Example quote") }

  it "shows a quote" do
    visit quotes_path
    click_link quote.name

    expect(page).to have_content(quote.name)
  end

  it "updates a quote" do
    visit quotes_path
    expect(page).to have_content("Quotes")

    click_on "Edit"
    expect(page).to have_content("Edit quote")

    fill_in "Name", with: "Updated quote"
    click_on "Update quote"

    expect(page).to have_content("Quotes")
    expect(page).to have_content("Updated quote")
  end

  it "destroys a quote" do
    visit quotes_path
    expect(page).to have_content(quote.name)

    click_on "Delete"

    expect(page).not_to have_content(quote.name)
  end
end
