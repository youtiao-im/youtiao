module AccessTokenHelpers
  def use_invalid_access_token
    allow(controller).to receive(:doorkeeper_token)\
    { FactoryGirl.create(:expired_access_token) }
  end

  def use_valid_access_token
    allow(controller).to receive(:doorkeeper_token)\
    { FactoryGirl.create(:access_token) }
  end

  def use_valid_access_token_for(user)
    allow(controller).to receive(:doorkeeper_token)\
    { FactoryGirl.create(:access_token, resource_owner_id: user.id) }
  end
end

RSpec.configure do |config|
  config.include AccessTokenHelpers, type: :controller
end
