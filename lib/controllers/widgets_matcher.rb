require 'action_controller/assertions/selector_assertions'

class WidgetsMatcher
  include ActionController::Assertions::SelectorAssertions

  def initialize(element)
    @element = element
  end

  def matches?(response_or_text)
    assert_select('<div></div>', 'div')
    #assert_select(response_or_text, 'select')
    #matcher = Spec::Rails::Matchers::AssertSelect.new(:assert_select, self, 'select')
    #p matcher
    #matcher.matches?(response_or_text)
    #matcher = have_tag?('select')
    #p matcher.matches?(response_or_text)
    #have_tag?(response_or_text).matches?(element)
    #p have_tag('select').matches?(response_or_text)
    #response_or_text.should have_tag('select')
  end
  
  def failure_message_for_should
    "expected to have a select tag, with '#{element}' selected" 
  end

  def failure_message_for_should_not
    "expected to not have a select tag, or have a select tag without '#{element}' selected"
  end
end

def have_selected_element(element)
  WidgetsMatcher.new(element)
end
