require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:player1) {Player.make!}
  let(:player2) {Player.make!}

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
    let(:game) {Game.create_with_player1(player1)}
    let(:player2) {Player.make!}
    context "signed in player1" do   
      before do 
        player_sign_in(player1)
        get :invite, params: {game_id: game.id}
      end
      
      it { should respond_with(:success) }
      it { should render_template(:invite) }
      it "assigns the correct game" do 
        expect(assigns(:game)).to eq(game)
        expect(assigns(:game).player1).to eq(player1)
      end
    end

    context "signed in player1" do   
      before do 
        player_sign_in(player2)
        get :invite, params: {game_id: game.id}
      end
      
      it { should respond_with(:success) }
      it { should render_template(:invite) }
      it "assigns the correct game" do 
        expect(assigns(:game)).to eq(game)
      end
    end

    context "signed in but with started game" do   
      before do 
        game.start_game(player2)
        player_sign_in(player1)
        get :invite, params: {game_id: game.id}
      end
      
      it { should respond_with(:redirect) }
      it { should redirect_to(game_path(game)) }
      it {should set_flash[:success]}
    end

    context "signed out" do
      before {get :create}
      it { should respond_with(:redirect) }
      it { should redirect_to(new_player_session_path) }
    end 
  end

  describe "POST #accept" do
    let(:game) {Game.create_with_player1(player1)}
    let(:player3) {Player.make!}

    context "signed in player1" do   
      before do 
        game.start_game(player2)
        player_sign_in(player1)
        post :accept, params: { game_id: game.id}
      end
      
      it { should respond_with(:redirect) }
      it { should redirect_to(game_path(game)) }
      it {should set_flash[:success]}
    end

    context "signed in player2" do   
      before do 
        player_sign_in(player2)
        post :accept, params: { game_id: game.id}
      end
      
      it { should respond_with(:redirect) }
      it { should redirect_to(game_path(game)) }
      it {should set_flash[:success]}

      it "assigns the correct game" do 
        expect(assigns(:game)).to eq(game)
        expect(assigns(:game).player2).to eq(player2)
      end
    end

    context "signed in player3" do   
      before do 
        game.start_game(player2)
        player_sign_in(player3)
        post :accept, params: { game_id: game.id}
      end
      
      it { should respond_with(:redirect) }
      it { should redirect_to(root_path) }
      it {should set_flash[:danger]}
    end
  end

  describe "GET #show" do
    let(:game) {Game.create_with_player1(player1)}
    let(:player3) {Player.make!}
    before { game.start_game(player2)}

    context "signed in player1" do   
      before do 
        player_sign_in(player1)
        get :show, params: {id: game.id}
      end
      
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it "assigns the correct game" do 
        expect(assigns(:game)).to eq(game)
        expect(assigns(:game).player1).to eq(player1)
      end
    end

    context "signed in player2" do   
      before do 
        player_sign_in(player2)
        get :show, params: {id: game.id}
      end
      
      it { should respond_with(:success) }
      it { should render_template(:show) }

      it "assigns the correct game" do 
        expect(assigns(:game)).to eq(game)
        expect(assigns(:game).player2).to eq(player2)
      end
    end

    context "signed in player3" do   
      before do 
        player_sign_in(player3)
        get :show, params: {id: game.id}
      end
      
      it { should respond_with(:redirect) }
      it { should redirect_to(root_path) }
      it {should set_flash[:danger]}
    end
  end

  def player_sign_in(player)
    allow(request.env['warden']).to receive(:authenticate!).and_return(player)
    allow(controller).to receive(:current_player).and_return(player)
  end
end
