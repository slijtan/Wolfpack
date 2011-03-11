class DemoController < ApplicationController

  def index
    @carriers = Carrier.order("name")
  end
end
