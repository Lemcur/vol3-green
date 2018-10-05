require 'rails_helper'

RSpec.describe CateringsController do
  let(:catering) { create(:catering) }
  let(:catering_id) { catering.id }
  let(:user) { create(:user) }

  context 'show action' do
    before { sign_in user }
    before { get :show, params: { catering_id } }
    it 'should show catering' do
      expect(response).to have_http_status(:success)
    end
  end
end
