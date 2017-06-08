require 'rails_helper'

RSpec.describe User, type: :model do
  it { should { validates_presence_of :first_name } }
end
