require 'rails_helper'

RSpec.describe Feed, type: :model do
  it { should belong_to :channel }
  it { should belong_to :creator }
end
