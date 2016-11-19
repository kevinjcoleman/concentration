require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:player1) {Player.make!}
  describe "POST #create" do
    context "signed in" do 
      before do 
        player_sign_in(player1)
        post :create 
      end
      
      it { should redirect_to(game_invite_path(1)) }
      it { should respond_with(:redirect) }
    end

    context "signed out" do
      before {post :create}
      it { should respond_with(:redirect) }
      it { should redirect_to(new_player_session_path) }
    end 
  end

  describe "GET #invite" do
    let(:game) {Game.make!}
    let(:player) {Player.make!}
    context "signed in" do   
      before do 
        player_sign_in(player1)
        get :invite, game_id: game.id
      end
      
      it { should respond_with(:success) }
      it { should render_template(:invite) }
      it "assigns the correct game" do 
        expect(assigns(:game)).to eq(game)
      end
    end

    context "signed out" do
      before {get :create}
      it { should respond_with(:redirect) }
      it { should redirect_to(new_player_session_path) }
    end 
  end

  def player_sign_in(player)
    allow(request.env['warden']).to receive(:authenticate!).and_return(player)
    allow(controller).to receive(:current_player).and_return(player)
  end
end
