module ApplicationHelper

  def full_title(title = '')
    base = 'Inspect Manager Center'
    title.empty? ? base : "#{title} | #{base}"
  end

end
