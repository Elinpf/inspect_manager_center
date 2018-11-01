class BrowsesController < ApplicationController

  # you can disable csrf protection on controller-by-controller basis:  
  protect_from_forgery except: :index 
  skip_before_action :verify_authenticity_token  

  def show
    @sf = StoreFile.find(params[:id])
    
    @device_manager = aio_parse_console(@sf.path)
  end

  def index
    @store_files = StoreFile.paginate(page: params[:page])
    @cl_group = StoreFile.client_and_location_group
  end

  def history
    @sf = StoreFile.find(params[:id])

    @history_arr = @sf.history
  end

  def compare
    compare_one = params['key1'].split('client-')[1]
    compare_two = params['key2'].split('client-')[1]
    return if compare_one.nil? or compare_two.nil?

    sf_one = StoreFile.find_by_id(compare_one)
    sf_two = StoreFile.find_by_id(compare_two)

    @device_manager = aio_parse_compare(sf_one.path, sf_two.path)
  end
end
