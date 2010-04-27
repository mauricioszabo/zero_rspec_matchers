require 'spec/spec_helper'
require 'controllers/widgets_matcher'

describe WidgetsController do
  integrate_views

  it 'should be able to identify a selected field on a select tag' do
    get :select
    response.should have_selected_element("Two")
    response.body.should_not have_selected_element("One")
  end
end
