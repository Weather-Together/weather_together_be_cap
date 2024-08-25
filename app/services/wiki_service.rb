class WikiService
  def conn
    Faraday.new(url: "https://en.wikipedia.org/w/api.php")
  end

  # Looks gross and should be refactored for readability
  # Also currently does not handle if there is no location data whatsoever
  def get_link(location)
    specificity = [:locality, :state, :region, :country]

    specificity.each do |level|
      unless location[level].nil?
        title = location[level]
        page_data = parse_wikipage(title)
        if valid_article?(page_data)
          return { 
                    location: title,
                    url: page_data[:url],
                    specificity: level.to_s
                  }
        end
      end
    end
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