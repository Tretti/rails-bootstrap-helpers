module Html
  def strip (html)
    html.gsub!("\n", "")
  end

  def strip_expected (html)
    html.gsub(/^\s+/, "").gsub("\n", "")
  end
end