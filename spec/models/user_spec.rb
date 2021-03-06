require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :username }
  it { should validate_length_of(:first_name).is_at_least(2).is_at_most(30) }
  it { should validate_length_of(:last_name).is_at_least(2).is_at_most(30) }
  it { should validate_length_of(:username).is_at_least(2).is_at_most(30) }
end
