module DoorkeeperHelpers
  def authenticate(user)
    allow(controller).to receive(:doorkeeper_token) do
      create(:access_token, resource_owner_id: user.id)
    end
  end
end

RSpec.configure do |config|
  config.include DoorkeeperHelpers, type: :controller
end
