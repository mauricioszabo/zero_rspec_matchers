class WidgetsController < ApplicationController
  def select
    @person = Struct.new(:age).new(2)
    render :inline => '
      <%= select :person, :age, [ [ "One", 1 ], [ "Two", 2 ] ] %>
    '
  end
end
