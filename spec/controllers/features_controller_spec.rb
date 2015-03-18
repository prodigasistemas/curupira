require "rails_helper"

describe Curupira::FeaturesController do
  	let(:user) { FactoryGirl.create :user }

  	before do
  		login_user(user)
  	end

  	describe "GET index" do
  		before do
  			FactoryGirl.create :feature
  			FactoryGirl.create :feature
  		end

  		it "should get index" do
      		get :index
      		expect(response).to be_success
    	end

    	it "returns all features" do
      		get :index
      		expect(assigns(:features).count).to eql 2
    	end
  	end

  	describe "GET new" do
    	it "should get new" do
      		get :new
      		expect(response).to be_success
    	end

    	it "returns new feature" do
      		get :new
      		expect(assigns(:feature)).to be_new_record
    	end
  	end

  	describe "GET edit" do
    	let(:feature) { FactoryGirl.create :feature }

    	context "when feature exists" do
      		it "should get edit" do
        		get :edit, id: feature
        		expect(response).to be_success
      		end

      		it "returns feature" do
        		get :edit, id: feature
        		expect(assigns(:feature)).to eql feature
      		end
    	end

    	context "when feature does not exist" do
      		it "renders 404" do
        		expect {
          			get :edit, id: "wrong id"
        		}.to raise_error ActiveRecord::RecordNotFound
      		end
    	end
  	end

  	describe "POST create" do
    	context "when feature is valid" do
      		let(:params)  { { name:"leitura" } }

      		it "should redirect to new feature" do
        		post :create, feature: params
        		expect(flash[:notice]).to eql "Nova Caracteristica cadastrada"
        	end	
      
      		it "should redirect to new feature" do
        		post :create, feature: params
        		expect(response).to redirect_to assigns(:feature)
      		end

      		it "creates feature" do
        		expect {
          			post :create, feature: params
        		}.to change { Feature.count }.by(1)
      		end
    	end
    end

  	describe "PUT update" do
     	let(:feature) { FactoryGirl.create :feature }

     	context "when feature is valid" do
     		let(:params)  { { name:"leitura" } }

       		it "sets flash message" do
         			put :update, id: feature, feature: params
         			expect(flash[:notice]).to eql "Caracteristica atualizada com sucesso"
      		end

      		it "redirects to feature" do
        			put :update, id: feature, feature: params
        			expect(response).to redirect_to assigns(:feature)
      		end

      		it "updates feature" do
        			put :update, id: feature, feature: params
        			expect(assigns(:feature).name).to   eql "leitura"
        			expect(assigns(:feature).active).to eql true
      		end
    		
  		end
  	end

  	describe "GET show" do
  		let(:feature) { FactoryGirl.create :feature }

    	context "when feature exists" do
    		it "should get show" do
        		get :show, id: feature
        		expect(response).to be_success
      		end

      		it "returns feature" do
        		get :show, id: feature
        		expect(assigns(:feature)).to eql feature
      		end
    	end

    	context "when feature does not exist" do
      		it "renders 404" do
        		expect {
          			get :show, id: "wrong id"
        		}.to raise_error ActiveRecord::RecordNotFound
      		end
    	end
  	end
end
