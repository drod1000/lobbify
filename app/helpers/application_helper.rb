module ApplicationHelper
  def path_cleaner(path)
    path.downcase.gsub('_',' ').titleize
  end

  def path_creator(name)
    name.downcase.titleize.gsub(' ','_')
  end

  def path_validator(path)
    Politician.find_by(name: path_cleaner(path)) 
  end
end
