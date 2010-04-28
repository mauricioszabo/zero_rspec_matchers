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
      target = extract_string(target)  
      @matches = find_id_and_text(target)
      matches_all_conditions?
    end

    private
    def extract_string(target)
      target = target.body if target.respond_to? :body
      target.gsub("\\u003C", "<").gsub("\\u003E", ">")
    end

    def find_id_and_text(target)
      if @kind == :html
        target.scan(REPLACE_HTML_REGEX)
      else
        target.scan(REPLACE_REGEX)
      end
    end

    def matches_all_conditions?
      return false if @matches.empty?
      if @block.nil?
        @matches.any? { |id, text| matches_id_and_text?(id, text) }
      else
        matches_all_with_block?
      end
    end

    def matches_all_with_block?
      @matches.any? { |id, text| matches_with_block?(id, text) }
    end

    def matches_with_block?(id, text)
      return false unless matches_id_and_text?(id, text)
      @block.call(text)
      return true
    end

    def matches_id_and_text?(id, text)
      matches_id = @id.is_a?(String) ? id == @id : true
      matches_text = @text.nil? ? true : @text === text
      matches_text && matches_id
    end

    def run_block(text)
      return true if @block.nil?
      @block.call(text)
    end

    public
    def with(text = nil, &block)
      if block
        @block = block
      else
        @text = text
        @should_failure += " with text \"#@text\""
      end

      self
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

