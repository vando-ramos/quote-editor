require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
    it 'returns the correct name' do
      kmpg = Company.create!(name: 'KMPG')
      user = User.create!(email: 'accountant@kpmg.com', password: 'password', company_id: kmpg.id)
      
      expect(user.name).to eq('Accountant')
    end
  end
end
