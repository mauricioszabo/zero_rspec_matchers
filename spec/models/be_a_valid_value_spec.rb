require 'spec/spec_helper'
require 'models/be_a_valid_value'

describe 'Model' do
  it 'should create a validation for invalid fields' do
    '1234'.should_not be_a_valid_value_for(:person, :id_card)
    '123456'.should be_a_valid_value_for(:person, :id_card)
  end
end
