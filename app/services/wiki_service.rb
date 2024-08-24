class WikiService
  def conn
    Faraday.new(url: "https://en.wikipedia.org/w/api.php")
  end

  def get_wikipage(titles)
    response = conn.get("?action=query&format=json&prop=info&inprop=url&titles=#{titles}")
    JSON.parse(response.body, symbolize_names: true)
  end
end