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

    tmp_response = "https://s3.us-east-2.amazonaws.com/mcategory/test6.wav"
    response = service.compose(scene)
    description = service.describe(scene)
    complete_response = {:link => tmp_response, :description => description}
    render :json => complete_response
  end

  def update

  end
end
