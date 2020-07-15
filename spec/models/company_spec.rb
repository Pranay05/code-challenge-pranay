require 'rails_helper'

RSpec.describe Company, type: :model do
    let(:company) { build(:company) }

    # Validation test
    # it { should have_db_index(:id) } note ==> if required
    it { should validate_presence_of(:name) }
    it { should allow_value('1234')
                  .for(:name)
                  .with_message('Optional')

    }
    # it { should validate_format_of(:email).with(/\A([^@\s]+)@getmainstreet.com\Z/i) } deprecated
    it { should allow_value('test@getmainstreet.com', 'Ab-@getmainstreet.com').for(:email) }
    it { should allow_value('').for(:email) }
    it { should allow_value(nil).for(:email) }
    it { should_not allow_value('test@anc.com', 'abc', '123@f.in').for(:email) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_length_of(:zip_code).is_at_least(5) }
    it { should have_db_column(:city).
      of_type(:string)
    }
    it { should have_db_column(:state).
      of_type(:string)
    }

    context 'callbacks' do
      # it { should callback(:city_and_state_based_on_pincode).before(:save) }
      it { is_expected.to callback(:city_and_state_based_on_pincode).before(:save) }
    end

end
