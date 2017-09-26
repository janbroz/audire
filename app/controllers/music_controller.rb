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

    uri = URI.parse("https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify")
    parameters = {:apikey => "e06af8f14f2d026a6d0c8728bae66ae4bbe494e8", :version => "2016-05-20"}
    x = Net::HTTP.post_form(uri, parameters)
    puts x.body
    # params = {"images_file" => "@#{param.path}"}
    # begin 
    #   response = Net::HTTP.post_form(uri, {})
    # rescue Zlib::BufError => er
    #   puts "Ayayayay: #{er}"
    # end

    #puts "Response is: #{response}"

    render :json => new_param
  end

  def update

  end
end
