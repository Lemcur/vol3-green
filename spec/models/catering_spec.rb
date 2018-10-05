require 'rails_helper'

RSpec.describe Catering, type: :model do
  context 'should have' do
    it 'many meals' do
      is_expected.to have_many(:meals)
    end
    it 'many daily meals' do
      is_expected.to have_many(:daily_meals)
    end
    it 'and belong to many users' do
      is_expected.to have_and_belong_to_many(:users)
    end
  end
  
end
