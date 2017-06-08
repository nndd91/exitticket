require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers) }
  it { should belong_to(:form_template) }
  it { should validate_presence_of(:qns_type) }
  it { should validate_presence_of(:label) }
  it { should validate_length_of(:label).is_at_most(255) }
end
