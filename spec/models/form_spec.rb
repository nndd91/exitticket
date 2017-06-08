require 'rails_helper'

RSpec.describe Form, type: :model do
  it { should belong_to(:form_template) }
  it { should belong_to(:user) }
  it { should have_many(:answers) }
  it { should have_many(:questions) }
  it { should have_many(:logs) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(255) }
  it { should validate_length_of(:description).is_at_most(1000) }

end
