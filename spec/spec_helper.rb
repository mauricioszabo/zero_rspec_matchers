$LOAD_PATH.unshift '../rspec/lib'
$LOAD_PATH.unshift 'lib/'
$LOAD_PATH.unshift 'spec/resources/controllers'
$LOAD_PATH.unshift 'spec/resources/helpers'

require 'active_support'
require 'action_controller'
require 'active_record'
#require '../../../spec/spec_helper'

require 'spec/resources/controllers/application'
require 'spec/resources/controllers/replace_controller'

require 'replace_matcher'

RAILS_ROOT = File.dirname(__FILE__) + "/spec/resources"
require 'initializer'
require 'spec/rails'
unless ActionController::Routing.controller_paths.include?('spec/resources/controllers')
  ActionController::Routing.instance_eval {@possible_controllers = nil}
  ActionController::Routing.controller_paths << 'spec/resources/controllers'
end

module Spec
  module Rails
    module Example
      class ViewExampleGroupController
        #prepend_view_path 'spec/resources/views'
      end
    end
  end
end

def fail()
  raise_error(Spec::Expectations::ExpectationNotMetError)
end
  
def fail_with(message)
  raise_error(Spec::Expectations::ExpectationNotMetError,message)
end

class Proc
  def should_pass
    lambda { self.call }.should_not raise_error
  end
end

ActionController::Routing::Routes.draw do |map|
  map.connect 'action_with_method_restriction', :controller => 'redirect_spec', :action => 'action_with_method_restriction', :conditions => { :method => :get }
  map.connect 'action_to_redirect_to_action_with_method_restriction', :controller => 'redirect_spec', :action => 'action_to_redirect_to_action_with_method_restriction'

  map.resources :rspec_on_rails_specs
  map.custom_route 'custom_route', :controller => 'custom_route_spec', :action => 'custom_route'
  map.connect ':controller/:action/:id'
end

module HelperMethods
  def method_in_module_included_in_configuration
  end
end

module HelperMacros
  def accesses_configured_helper_methods
    it "has access to methods in modules included in configuration" do
      method_in_module_included_in_configuration
    end
  end
end

Spec::Runner.configure do |config|
  config.include HelperMethods
  config.extend HelperMacros
end

