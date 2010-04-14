require 'spec/spec_helper'

describe ReplaceController do
  integrate_views

  context 'when replacing inner_html\'s' do
    it 'should be able to identify that it is receiving a "replace_html" tag' do
      get :replace_html
      response.should replace_html
    end

    it 'should be able to identify which element is being replaced' do
      get :replace_html
      response.should replace_html_of(:element)
      response.should_not replace_html_of(:element10)
    end

    it 'should be able to match the text' do
      get :replace_html
      response.should replace_html.with('Another Text')
      response.should replace_html_of(:element2).with("Another Text")
      response.should_not replace_html_of(:element).with("Another Text")
    end

    it 'should be able to match the text with another matchers' do
      response.should replace_html_of(:element).with_something_that {
        have_tag('div')
      }
    end
  end

  context 'when replacing the whole element' do
    it 'should be able to identify that it is receiving a "replace" tag' do
      get :replace
      response.should replace_element
    end

    it 'should be able to identify which element is being replaced' do
      get :replace
      response.should replace_element(:element)
      response.should_not replace(:element10)
    end

    it 'should be able to match the text' do
      get :replace
      response.should replace_element.with('Another Text')
      response.should replace_element(:element2).with("Another Text")
      response.should_not replace_element(:element).with("Another Text")
    end
  end
end
