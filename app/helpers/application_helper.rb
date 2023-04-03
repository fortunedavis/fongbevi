module ApplicationHelper
  include Pagy::Frontend
  
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
  

  def current_clip?(test_path)
    request.path == test_path ? "text-decoration-line: underline py-4 px-2 text-red-500 font-semibold hover:text-gray-100 transition duration-300" :
    "py-4 px-2 text-red-500 font-semibold hover:text-gray-100 transition duration-300"
  end

  def current_voice?(test_path)
    request.path == test_path ? "text-decoration-line: underline py-4 px-2 text-green-700 font-semibold hover:text-gray-100 transition duration-300" :
    "py-4 px-2 text-green-500 font-semibold hover:text-gray-100 transition duration-300"
  end

end
