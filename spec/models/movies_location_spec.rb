require 'rails_helper'

describe MoviesLocation do

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:movie) }
    it { is_expected.to validate_presence_of(:location) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:movie)}
    it { is_expected.to belong_to(:location) }
  end

end
