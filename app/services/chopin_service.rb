# app/services/chopin_service.rb

class ChopinService

  # We pass the image to bluemix and get the json back
  def inspirate(picture)
    json_partiture = { :categories => "tara!" }


    json_partiture
  end


  # We pass the bluemix json
  def compose(partiture)
    # This should be doing the parsing and stuff

    response = {file: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"}
  end

end
