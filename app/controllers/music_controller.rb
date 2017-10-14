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

    uri = URI.parse("https://gateway-a.watsonplatform.net/visual-recognition/api/v3/classify?api_key=e06af8f14f2d026a6d0c8728bae66ae4bbe494e8&version=2016-05-20")

    t_response = {}
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = param.read
      request["Content-Type"] = "image/jpg"
      request['Accept-Encoding'] = ''
      response = http.request(request)
      t_response = response.body
    end

    puts t_response

    service = ChopinService.new
    response = service.compose(t_response)

    render :json => response
  end

  def update

  end
end
