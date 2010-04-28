class WidgetsController < ApplicationController
  def select
    @person = Struct.new(:age).new(2)
    render :inline => '
      <%= select :person, :age, [ [ "One", 1 ], [ "Two", 2 ] ] %>
    '
  end

  def checkbox
    @person = Struct.new(:age).new(2)
    render :inline => '
      <%= label :person, :age, "Two" %> <%= check_box :person, :age %>
    '
  end

  def radiobutton
    @person = Struct.new(:age).new("Two")
    render :inline => '
      <%= label_tag :person_age_one, "One" %> <%= radio_button :person, :age, "One" %>
      <%= label_tag :person_age_two, "Two" %> <%= radio_button :person, :age, "Two" %>
    '
  end
end
