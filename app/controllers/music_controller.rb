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

    service = ChopinService.new
    scene = service.imagine(param)
    partiture_descriptor = service.sonic_partiture(scene)
    partiture = service.create_partiture(partiture_descriptor)
    # tmp_response = "https://s3.us-east-2.amazonaws.com/mcategory/test6.wav"
    # response = service.compose(scene)
    description = service.describe(scene)
    #complete_response = {:link => response, :description => description}

    # Call our amazon stuff
    #uri = URI.parse("http://52.91.82.138:2000")

    # uri = URI.parse("http://localhost:2000")
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Post.new(uri.request_uri)
    # request.body = {holi: "holi there"}.to_json
    # response = http.request(request)
    #puts partiture


    response = service.talk_to_ec2(partiture)
    complete_response = {:link => response, :description => description}
    #puts response.body
    # end of our amazon stuff.
    render :json => complete_response
    #render :json => complete_response
  end

  def update

  end
end
