class ReplaceController < ApplicationController
  def replace_html
    render :update do |pag|
      pag[:element].replace_html "A div: <div id='replaced'>Something</div>"
      pag[:element2].replace_html "Another Text"
    end
  end

  def replace
    render :update do |pag|
      pag[:element].replace "<div id='replaced'>Something</div>"
      pag[:element2].replace "Another Text"
    end
  end
end
