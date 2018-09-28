module ApplicationHelper

  def full_title(title = '')
    base = 'Inspect Manager Center'
    title.empty? ? base : "#{title} | #{base}"
  end

  def login_path?
    request.path_info == '/users/sign_in'
  end

end
