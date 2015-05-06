require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should belong_to :feed }
  it { should belong_to :creator }
end
