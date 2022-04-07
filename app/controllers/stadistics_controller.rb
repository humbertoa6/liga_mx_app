class StadisticsController < ApplicationController

  def fixtures
    response = Service::Stadistics::Fixtures.new.execute

    render json: response, status: :ok
  end

  def livescores
    response = Service::Stadistics::Livescores.new.execute

    render json: response, status: :ok
  end

  def standings
    response = Service::Stadistics::Standings.new.execute

    render json: response, status: :ok
  end

  def welcome
    render json: { message: 'Welcome to Liga Mx stats' }
  end
end
