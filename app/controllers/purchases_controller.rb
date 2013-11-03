class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_access, only: [:show]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = current_user.purchases
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new

    @pre_selected_event = get_event_id_from_param(params[:event_id])
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    event_id = purchase_params[:event_id]
    @event = Event.find(event_id)
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        @event.update_total_balance
        # Update all user_event_balances
        @purchase.event.user_event_balances.each do |ueb|
          ueb.update_debt
          ueb.update_credit
        end

        format.html { redirect_to @event, notice: 'Purchase was successfully created.' }
        format.json { render action: 'show', status: :created, location: @purchase }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        @event.update_total_balance

        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy

    @purchase.destroy
    respond_to do |format|

      format.html { redirect_to purchases_url }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:amount, :description, :event_id, :user_id)
    end

    def check_owner
      unless @purchase.user_id == current_user.id
        redirect_to root_url, :notice => "You can't access this page"
      end
    end

    def check_access
      unless get_users_in_event(@purchase.event).include? current_user.id
        redirect_to root_url, :notice => "You can't access this page"
      end
    end
end
