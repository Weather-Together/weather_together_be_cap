class WikiService
  def conn
    Faraday.new(url: "https://en.wikipedia.org/w/api.php")
  end

  def parse_wikipage(titles)
    response = conn.get("?action=query&format=json&prop=info&inprop=url&titles=#{titles}")
    pages = JSON.parse(response.body, symbolize_names: true)[:query][:pages]
    articlenum = pages.keys.first
    url = pages[articlenum][:fullurl]

    {
      articlenum: articlenum.to_s.to_i,
      url: url,
    }
  end

  def valid_article?(wikipage_data)
    wikipage_data[:articlenum] > 0
  end
end