module TokenHelpers
  def set_invalid_token
    allow(controller).to receive(:doorkeeper_token)\
    { FactoryGirl.create(:expired_access_token) }
  end

  def set_valid_token
    allow(controller).to receive(:doorkeeper_token)\
    { FactoryGirl.create(:access_token) }
  end

  def set_valid_token_for(user)
    allow(controller).to receive(:doorkeeper_token)\
    { FactoryGirl.create(:access_token, resource_owner_id: user.id) }
  end
end

RSpec.configure do |config|
  config.include TokenHelpers, type: :controller
end
