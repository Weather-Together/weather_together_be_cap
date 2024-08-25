class ImageService
  def conn
    Faraday.new(url: "https://api.unsplash.com/")
  end

  def get_images(location)
    specificity = [:locality, :state, :region, :country]

    specificity.each do |level|
      unless location[level].nil?
        search_term = location[level]
        image_data = parse_image_data(search_term)
        if images_exist?(image_data)
          return { 
                    location: search_term,
                    urls: image_data[:urls],
                    specificity: level.to_s
                  }
        end
      end
    end
  end

  private

  def parse_image_data(search_term)
    response = conn.get("search/photos/") do |f|
      f.params["client_id"] = Rails.application.credentials.image_api[:key]
      f.params["query"] = search_term
      f.params["page"] = "1"  # Limits to 10 images
    end
    hash = JSON.parse(response.body, symbolize_names: true)
    results = hash[:results]
    urls = results.map do |result|
      result[:urls][:full]
    end

    {
      total: hash[:total],
      urls: urls,
    }
  end

  def images_exist?(image_data)
    image_data[:total] > 0
  end
end
