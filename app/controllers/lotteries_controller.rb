class LotteriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @lotteries = Lottery.all

    render("lotteries/index.html.erb")
  end

  def show
    @lottery = Lottery.find(params[:id])

    render("lotteries/show.html.erb")
  end

  def new
    @lottery = Lottery.new

    render("lotteries/new.html.erb")
  end

  def create
    @lottery = Lottery.new

    @lottery.transactions_id = params[:transactions_id]
    @lottery.user_id = params[:user_id]
    @lottery.amount = params[:amount]
    @lottery.raffle_number = params[:raffle_number]
    @lottery.date = params[:date]

    save_status = @lottery.save

    if save_status == true
      redirect_to("/lotteries/#{@lottery.id}", :notice => "Lottery created successfully.")
    else
      render("lotteries/new.html.erb")
    end
  end

  def edit
    @lottery = Lottery.find(params[:id])

    render("lotteries/edit.html.erb")
  end

  def update
    @lottery = Lottery.find(params[:id])

    @lottery.transactions_id = params[:transactions_id]
    @lottery.user_id = params[:user_id]
    @lottery.amount = params[:amount]
    @lottery.raffle_number = params[:raffle_number]
    @lottery.date = params[:date]

    save_status = @lottery.save

    if save_status == true
      redirect_to("/lotteries/#{@lottery.id}", :notice => "Lottery updated successfully.")
    else
      render("lotteries/edit.html.erb")
    end
  end

  def destroy
    @lottery = Lottery.find(params[:id])

    @lottery.destroy

    if URI(request.referer).path == "/lotteries/#{@lottery.id}"
      redirect_to("/", :notice => "Lottery deleted.")
    else
      redirect_to(:back, :notice => "Lottery deleted.")
    end
  end
end