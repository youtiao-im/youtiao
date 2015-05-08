require 'rails_helper'

RSpec.describe Stamp, type: :model do
  it { should belong_to :feed }
  it { should belong_to :user }
end
