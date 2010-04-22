module Models
  class ValidationsMatcher
    def initialize(attributes, kind)
      @attributes = attributes
      @kind = kind
    end
  
    def matches?(target)
      @class = target.to_s.camelcase.constantize
      case @kind
        when :presence
          validates_presence
        when :numericality
          validates_numericality
      end
    end
  
    def failure_message
      "expected #@class to validate #@kind of #{@attributes.to_sentence}."
    end
  
    def negative_failure_message
      "expected #@class not to validate #@kind of #{@attributes.to_sentence}."
    end
  
    private
    def validates_presence
      new = @class.new
      new.valid?
      @attributes.all? { |a| !new.errors_on(a).empty? }
    end
  
    def validates_numericality
      new = @class.new
      @attributes.each { |a| new.send "#{a}=", 'test' }
      new.valid?
      @attributes.all? { |a| !new.errors_on(a).empty? }
    end
  
    def validates_format
      new = @args.delete_at(0).new
      @args.each do |arg|
        new[arg] = @class
      end
      new.valid?
      @attributes.all? { |a| new.errors_on(a).empty? }
    end
  end
end

def validate_presence_of(*args)
  Models::ValidationsMatcher.new(args, :presence)
end

def validate_numericality_of(*args)
  Models::ValidationsMatcher.new(args, :numericality)
end

def be_a_valid_value_for(*args)
  Models::ValidationsMatcher.new(args, :format)
end
alias :be_valid_value_for :be_a_valid_value_for
