module ApplicationHelper
  def path_cleaner(path)
    path.downcase.gsub("_"," ").titleize
  end
end
