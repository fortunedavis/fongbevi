module ApplicationHelper
  def current?(key, path)
    "#{key}" if current_page? path
  end

  def current_class?(test_path)
    request.path == test_path ? 'block pl-4 align-middle
    text-gray-700 no-underline 
    hover:text-purple-500 
    border-l-4 border-transparent
    lg:border-purple-500
    lg:hover:border-purple-500' :
    'block pl-4 align-middle
    text-gray-700 no-underline 
    hover:text-purple-500 
    border-l-4 border-transparent
    pb-1 md:pb-0
    text-sm
    text-gray-900 font-bold
     '
  end

end
