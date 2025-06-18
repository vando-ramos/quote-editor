require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valid' do
    it "name can't be blank" do
      company = Company.new(name: '')

      expect(company.valid?).to eq false
    end
  end

  describe 'associations' do
    it { should have_many(:users) }
    it { should have_many(:quotes) }
  end
end
