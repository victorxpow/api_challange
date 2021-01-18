require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:account_number) }
  it { should validate_presence_of(:balance) }
  it { should validate_presence_of(:token) }
end
