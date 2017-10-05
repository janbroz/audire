class MusicController < ApplicationController

  def index

  end

  def new

  end

  def show
  end

  def create
    @stuff = params[:something]
    puts "Create was called with #{@stuff}"

    render :nothing => true
    #redirect_to action: "index"
  end

  def destroy
  end

  def upload_photo
    # This controller recives a Photo from a post method and
    # does a call to bluemix.
    param = params[:upload]
    puts "Params are: #{param.path}"
    new_param = "New param is: #{param}"

    #uri = URI.parse("https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?api_key=e06af8f14f2d026a6d0c8728bae66ae4bbe494e8&version=2016-05-20")


    # params = {'box1' => 'Nothing is less important than which fork you use. Etiquette is the science of living. It embraces everything. It is ethics. It is honor. -Emily Post',
# 'button1' => 'Submit'
#              }
#     x = Net::HTTP.post_form(URI.parse('http://posttestserver.com/post.php'), params)
    #     puts x.body
    #uri = URI("https://watson-api-explorer.mybluemix.net/visual-recognition/api/v3/classify?version=2016-05-20")
    #uri = URI("https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?api_key=e06af8f14f2d026a6d0c8728bae66ae4bbe494e8&version=2016-05-20")
    # req = Net::HTTP::Post.new("https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?api_key=e06af8f14f2d026a6d0c8728bae66ae4bbe494e8&version=2016-05-20")
    
    #http = Net::HTTP.new(uri.host, uri.port)
    #http.use_ssl = true

    #req = Net::HTTP::Post.new(uri.path)
    #req.set_form_data(:api_key => "e06af8f14f2d026a6d0c8728bae66ae4bbe494e8")
    #res = http.request(req)

    #puts res.body
    # case res
    # when Net::HTTPSuccess, Net::HTTPRedirection
    # # OK
    # else
    #   res.value
    # end


    # HERE IS the usable code

    
    # url = 'https://watson-api-explorer.mybluemix.net/visual-recognition/api/v3/classify?api_key=e06af8f14f2d026a6d0c8728bae66ae4bbe494e8?version=2016-05-20'
    # uri = Addressable::URI.parse(url)
    # response = RestClient::Request.execute(method: :post, url: url, payload: {:api_key => "e06af8f14f2d026a6d0c8728bae66ae4bbe494e8",:version => "2016-05-20"})

    # puts response


    # HERE ENDS the usable code
    
    # req = Net::HTTP::Post.new(uri.path)
    # sock = Net::HTTP.new(uri.host, uri.port)
    # sock.use_ssl = true
    # resp = sock.start {|http| http.request(req)}
    # puts resp
    #uri2 = Addressable::URI.parse(uri)
    # enc_uri = URI.encode(url)
    # uri = URI.parse(enc_uri)
    #x = Net::HTTP.post_form(uri, 'q' => 'ruby')
    #puts x.body

    #service = WatsonAPIClient::VisualRecognition.new(:api_key => "e06af8f14f2d026a6d0c8728bae66ae4bbe494e8", :version => "2016-05-20")
    #result = service.detect_faces_post('image_file' => open('face.png','rb'))
    #pp JSON.parse(result.body)
    #puts WatsonAPIClient::AlchemyLanguage::API['digest']
    #service2 = WatsonAPIClient::VisualRecognition.new(:api_key=>"...", :version=>'2016-05-20')
    # params = {"images_file" => "@#{param.path}"}
    # begin 
    #   response = Net::HTTP.post_form(uri, {})
    # rescue Zlib::BufError => er
    #   puts "Ayayayay: #{er}"
    # end

    #puts "Response is: #{response}"

    response = {file: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"}

    render :json => response
  end

  def update

  end
end
