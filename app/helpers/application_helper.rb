module ApplicationHelper
  def add_to_js(*js)
    (@page_js ||= []) << js
  end

  def add_to_css(*css)
    (@page_css ||= []) << css
  end
end
