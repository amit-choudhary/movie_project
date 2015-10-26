require 'rails_helper'

describe Location do

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:movies_locations).dependent(:destroy) }
    it { is_expected.to have_many(:movies).through(:movies_locations) }
  end

end
