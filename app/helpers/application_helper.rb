module ApplicationHelper
  
  #  Sets page title 
  def provide_title(title = '')
    page_title = "Facebook"

    if title.empty?
      page_title
    else
      "#{title} | #{page_title}"
    end 
  end

end
