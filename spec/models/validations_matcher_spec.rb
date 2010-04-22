require 'spec/spec_helper'
require 'models/validations_matcher'

describe Models::ValidationsMatcher do
  it 'should validate the presence on a model' do
    :person.should validate_presence_of(:name)
    :person.should_not validate_presence_of(:address)
  end

  it 'should check if a field is a number' do
    :person.should validate_numericality_of(:age)
    :person.should_not validate_numericality_of(:name)
  end
end
