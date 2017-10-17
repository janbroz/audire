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

    if (new["score"].to_f > current["score"].to_f) && valid_category(new["class"])
      {"name"=> new["class"], "score" => new["score"]}
    else
      current
    end
  end

  def get_sound(name)
    category = CategoryInformation.where(name: name)[0]
    null_cat = CategoryInformation.where(name: 'nothing')[0].url
    if category
      category.url
    else
      null_cat
    end
    # This one works, but is ugly as fuck
    # case name
    # when "person"
    #   CategoryInformation.where(name: "Person")[0].url
    # when "animal"
    #   CategoryInformation.where(name: "Animal")[0].url
    # when "man"
    #   CategoryInformation.where(name: "Man")[0].url
    # when "woman"
    #   CategoryInformation.where(name: "Woman")[0].url
    # when "fruit"
    #   CategoryInformation.where(name: "Fruit")[0].url
    # when "food"
    #   CategoryInformation.where(name: "Food")[0].url
    # when "cat"
    #   CategoryInformation.where(name: "Cat")[0].url
    # when "dog"
    #   CategoryInformation.where(name: "Dog")[0].url
    # when "weapon"
    #   CategoryInformation.where(name: "Weapon")[0].url
    # when "yellow color"
    #   CategoryInformation.where(name: "Yellow")[0].url
    # when "blue color"
    #   CategoryInformation.where(name: "Blue")[0].url
    # when "green color"
    #   CategoryInformation.where(name: "Green")[0].url
    # when "red color"
    #   CategoryInformation.where(name: "Red")[0].url
    # when "black color"
    #   CategoryInformation.where(name: "Red")[0].url
    # else
    #   CategoryInformation.where(name: "Nothing")[0].url
    # end
  end

  def valid_category(name)
    valid_ones = ['animal','person','man','woman','fruit','food','cat','dog','weapon','yellow color','blue color','green color','red color','black color','nothing']
    contains = valid_ones.include? name
  end
end
