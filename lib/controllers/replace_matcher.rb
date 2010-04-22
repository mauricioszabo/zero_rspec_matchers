module Controllers
  class ReplaceMatcher
    REPLACE_HTML_REGEX = /\$\("(.+?)"\)\.update\("(.*?)"\);/
    REPLACE_REGEX = /\$\("(.+?)"\)\.replace\("(.*?)"\);/
  
    def initialize(id = :any, kind = :html)
      @id = id
      @kind = kind
      
      @should_failure = "expected text or response to replace #@kind"
      @should_failure += " of element \"#@id\"" if @id != :any
    end
  
    def matches?(target)
      target = target.body if target.respond_to? :body
      target = target.gsub("\\u003C", "<").gsub("\\u003E", ">")
  
      @matches = if @kind == :html
        target.scan(REPLACE_HTML_REGEX)
      else
        target.scan(REPLACE_REGEX)
      end
      
      if @matches.empty?
        false
      else
        if @id.is_a?(String)
          if @text.nil?
            @matches.any? { |id, text| id == @id }
          else
            @matches.any? { |id, text| id == @id && text == @text }
          end
        else
          if @text.nil?
            true
          else
            @matches.any? { |id, text| text == @text }
          end
        end
      end
    end
  
    def with(text)
      @text = text
      @should_failure += " with text \"#@text\""
      self
    end
  
    def with_something_that(&b)
      p b
      instance_eval(&b)
    end
  
    def failure_message_for_should
      @should_failure
    end
  
    def failure_message_for_should_not
      @should_failure.gsub(' to ', ' to not ')
    end
  end
end

def replace_html
  Controllers::ReplaceMatcher.new
end
alias :replace_text :replace_html 
alias :replace_inner_html :replace_html 

def replace_html_of(element)
  Controllers::ReplaceMatcher.new element.to_s
end
alias :replace_text_of :replace_html_of
alias :replace_inner_html_of :replace_html_of

def replace(element = :any)
  if element == :any
    Controllers::ReplaceMatcher.new :any, :element
  else
    Controllers::ReplaceMatcher.new element.to_s, :element
  end
end
alias :replace_element :replace

