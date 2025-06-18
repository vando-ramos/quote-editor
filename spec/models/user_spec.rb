require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
    it 'returns the correct name' do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company: kmpg)
      
      expect(user.name).to eq('Accountant')
    end
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
