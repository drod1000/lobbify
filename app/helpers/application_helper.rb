module ApplicationHelper
  def path_cleaner(path)
    path.gsub('_',' ')
  end

  def path_creator(name)
    name.gsub(' ','_')
  end

  def path_validator(path)
    # Politician.find_by(name: path_cleaner(path))
    Politician.find_by('lower(name) = ?', path_cleaner(path).downcase)
  end
end
