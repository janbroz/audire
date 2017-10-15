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

    puts "Response from bluemix was:"
    j_partiture = JSON.parse(partiture)
    puts j_partiture

    music = {"name" => "nothing", "score" => 0}
    images = j_partiture["images"]
    classifiers = images[0]["classifiers"]
    classes = classifiers[0]["classes"]
    classes.each do |cl|
      music = parse_class(music, cl)
      #puts cl
    end
    response = get_sound(music["name"])
  end

  def parse_class(current, new)
    #puts "current is: #{current}"
    #puts "new is: #{new}"

    if new["score"].to_f > current["score"].to_f
      {"name"=> new["class"], "score" => new["score"]}
    else
      current
    end
  end

  def get_sound(name)
    case name
    when "person"
      CategoryInformation.where(name: "Person")[0].url
    when "animal"
      CategoryInformation.where(name: "Animal")[0].url
    when "fruit"
      CategoryInformation.where(name: "Fruit")[0].url
    else
      CategoryInformation.where(name: "Nothing")[0].url
    end
  end
end
