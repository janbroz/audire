# app/services/chopin_service.rb

class ChopinService

  # We pass the image to bluemix and get the json back
  def imagine(picture)
    uri = URI.parse("https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?api_key=e06af8f14f2d026a6d0c8728bae66ae4bbe494e8&version=2016-05-20")
    t_response = {}
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = picture.read
      request["Content-Type"] = "image/jpg"
      request['Accept-Encoding'] = ''
      response = http.request(request)
      t_response = response.body
    end
    #puts t_response
    t_response
  end

  # Create the sonic-pi rb file.
  def sonic_partiture(json_from)
    json = JSON.parse(json_from)
    classes = json["images"].first["classifiers"].first["classes"]
    resp = {"main": "rain", "secondary": []}
    main = 0
    classes.each do |cl|
      if resp[:main] == nil
        resp[:main] = cl["class"]
        main = cl["score"]
      end
      if cl["score"] > main
        resp[:secondary].push(resp[:main])
        resp[:main] = cl[:class]
        main = cl["score"]
      else
        resp[:secondary].push cl["class"]
      end
    end
    resp
  end

  def create_partiture(json)
    main_class = json[:main]
    secondary_classes = json[:secondary]
    s_length = secondary_classes.length

    current_stuff = []
    # Main part of the code generator
    code = "START\nlive_loop :main do\n  sample \"#{get_sample(main_class)}\"\n  sleep sample_duration \"#{get_sample(main_class)}\"\nend\n"

    code << "sleep 3\n"
    current_stuff << get_sample(main_class)
    # Secondary part of the code generator(each category is a loop)

    secondary_classes.each_with_index do |c_class, index|
      nname = get_sample(c_class)
      if nname != "" && !current_stuff.include?(nname)
        tmp = "sample \"#{get_sample(c_class)}\"\nsleep 1\n"
        code = code + tmp
      end
    end
    #   tmp = "live_loop :#{(index+1).humanize} do\n  sample #{get_sample(c_class)}\n  sleep sample_duration #{get_sample(c_class)}\nend\n"
    #   code = code + tmp
    # end

    code << "END"
    file = Tempfile.new(['foo', '.rb'])
    file.write(code)
    file.rewind
    file
  end

  def get_sample(sample)
    # This gets the sample url from the database.
    s_name = "/home/sonicpi/sonicpi/samples/#{contains(sample)}.wav"
    #s_name = "/home/pan/giskards-positronic-brain/visual-classifier/sonicpi/samples/#{contains(sample)}.wav"
    s_name
  end

  def contains(name)
    new_name = name
    if name.include?("dog")
      new_name = "dog"
    end
    if name.include?("cat") || name.include?("feline")
      new_name = "cat"
    end
    if name.include?("bird")
      new_name = "bird"
    end
    if name.include?("plant")
      new_name = "tree"
    end
    if name.include?("color")
      new_name = ""
    end
    if name == ""
      new_name = "fire"
    end
    return new_name
  end

  def talk_to_ec2(file)
    #uri = URI('http://localhost:2000')
    uri = URI.parse("http://52.91.82.138:2000")
    request = Net::HTTP::Post.new(uri)
    form_data = [['files', file]]

    request.set_form form_data, 'multipart/form-data'
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
    response.body
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
      # This means this class has a hierarchy that should be
      # proccessed before calculating their importance.
      hierarchy = cl["type_hierarchy"]
      levels = []
      if hierarchy != nil
        hierarchy[0] = ''
        levels = hierarchy.split('/')
        puts "#{cl["class"]} has: #{levels.length}"
        #puts levels
        #puts cl
      end
      music = parse_class(music, cl, levels)
      #puts "contender is: #{music["name"]} : #{music["score"]}"
    end
    response = get_sound(music["name"])
  end

  def parse_class(current, new, levels)
    if levels.include? current["name"] && valid_category(new["class"])
      {"name"=> new["class"], "score" => new["score"]}
    else
      if (new["score"].to_f > current["score"].to_f) && valid_category(new["class"])
        {"name"=> new["class"], "score" => new["score"]}
      else
        current
      end
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
  end

  def describe(scene)
    # Return a json with the scene objects
    objects = []
    json_scene = JSON.parse(scene)
    images = json_scene["images"]
    classifiers = images[0]["classifiers"]
    classes = classifiers[0]["classes"]

    classes.each do |s_class|
      objects << s_class["class"]
    end
    "The scene has: #{objects.join(", ")}"
  end

  def describe_speech(scene)
    #this should get a .wav from watson.

    #curl -X POST -u "26305cac-94e6-493c-a37b-ab91a1cd3167":"d3EV40JdRZW7" --header "Content-Type: application/json" --header "Accept: audio/wav" --data "{\"text\":\"The scene has: banana, fruit, diet (food), food, honeydew, melon, olive color, lemon yellow color\"}" --output hello_world.wav "https://stream.watsonplatform.net/text-to-speech/api/v1/synthesize?voice=en-US_AllisonVoice"
  end

  def valid_category(name)
    valid_ones = ['animal','person','man','woman','fruit','food','cat','dog','weapon','yellow color','blue color','green color','red color','black color','nothing']
    contains = valid_ones.include? name
  end
end
