Spec::Matchers.define :be_a_valid_value_for do |model, *fields|
  match do |value|
    model = model.to_s.camelcase.constantize
    model = model.new

    fields.each do |field|
      model[field] = value
    end
    
    model.valid?
    fields.all? { |f| model.errors_on(f).empty? }
  end

  failure_message_for_should do |value|
    "Expected '#{value} to be a valid value for the model and attributes"
  end

  failure_message_for_should_not do |value|
    "Expected '#{value} to not be a valid value for the model and attributes"
  end
end
