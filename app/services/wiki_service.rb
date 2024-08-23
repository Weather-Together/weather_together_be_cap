class WikiService
  def conn
    Faraday.new(url: "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=info&inprop=url&titles=")
  end
end