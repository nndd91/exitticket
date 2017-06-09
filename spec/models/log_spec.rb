require 'rails_helper'

RSpec.describe Log, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:form) }
  it { should validate_presence_of(:form) }
  it { should validate_presence_of(:user) }

  context 'testing uniqueness' do
    #it { should validate_uniqueness_of(:form).scoped_to(:user).ignoring_case_sensitivity }
  end

end
