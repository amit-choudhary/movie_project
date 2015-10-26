require 'rails_helper'

describe Movie do

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:movies_locations).dependent(:destroy) }
    it { is_expected.to have_many(:locations).through(:movies_locations) }
  end

end
