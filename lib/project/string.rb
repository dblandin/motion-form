class String
  def titleize
    gsub('_', ' ').split(/(\W)/).map(&:capitalize).join
  end
end
