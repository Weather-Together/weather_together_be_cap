class LocationInfoFacade
  def combine_location_information(lat, lon)
    gs = GeocodingService.new.get_location(lat, lon)
    is = ImageService.new.get_images(gs)
    ws = WikiService.new.get_link(gs)

    {location: gs, 
    images: is[:urls], 
    wiki: ws[:url]}
  end
end
