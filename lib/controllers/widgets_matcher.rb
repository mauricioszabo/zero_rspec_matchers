class WidgetsMatcher
  def initialize(matcher, element)
    @matcher = matcher
    @element = element
  end

  def matches?(response_or_text)
    if @matcher.is_a?(Array)
      @matcher.any? { |m| m.matches?(response_or_text) }
    else
      @matcher.matches?(response_or_text)
    end
  end
  
  def failure_message_for_should
    "expected to have '#@element' selected" 
  end

  def failure_message_for_should_not
    "expected to not have '#@element' selected"
  end
end

def have_selected_element(element)
  matcher = have_tag('option[selected]', :text => /#{Regexp.escape element}/)
  WidgetsMatcher.new matcher, element
end

def have_selected_box(element)
  matchers = []
  assert_select 'input[type=checkbox][checked]' do |elements|
    matchers = elements.collect { |e| have_tag('label', :text => /#{Regexp.escape element}/) }
  end
  WidgetsMatcher.new matchers, element
end

def have_selected_radio(element)
  matchers = []
  assert_select 'input[type=radio][checked]' do |elements|
    matchers = elements.collect { |e| have_tag('label', :text => /#{Regexp.escape element}/) }
  end
  WidgetsMatcher.new matchers, element
end
alias :have_selected_option :have_selected_radio
