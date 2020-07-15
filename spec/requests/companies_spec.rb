require 'rails_helper'

RSpec.describe "Companies", type: :request do

  describe "GET /home" do
    it "visit home path" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
  let(:company) { create(:company) }
  let(:valid_company) { build(:company) }
  let(:invalid_company) { build(:invalid_company) }


  describe "GET #index" do
    it "populates an array of Companies" do
      get companies_path
      assigns(:companies).should eq([company])
    end
    it "renders the :index view" do
      get companies_path
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested company to @company" do
      get company_path(company)
      assigns(:company).should eq(company)
    end
    it "renders the :show template" do
      get company_path(company)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
        get new_company_path
        response.should render_template :new
      end
    end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new company" do
        expect{
          post companies_path, params: {company: valid_company }
          # some issue with url pattern
        }.to change(Company,:count).by(1)
      end

      it "redirects to the new company" do
        post post companies_path(valid_company), params: {company: valid_company }
        # some syntax issue with url pattern
        response.should redirect_to Company.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new company" do
        expect{
          post companies_path(invalid_company), params: {company: invalid_company }
        }.to_not change(Company,:count)
      end

      it "re-renders the new method" do
        post companies_path, params: {company: invalid_company }
        response.should render_template :new
      end
    end
  end

  describe 'Patch update' do

    context "valid attributes" do
      it "located the requested company" do
        patch company_path(company)
        assigns(:company).should eq(company)
      end

      it "changes @company's attributes" do
        patch company_path(company), params: {company: {name: 'larry sobers'} }
        company.reload
        company.name.should eq('larry sobers')
      end

      it "redirects to the updated company" do
        patch company_path(company), params: {company: {name: 'larry sobers'} }
        response.should redirect_to company
      end
    end

    context "invalid attributes" do
      it "locates the requested company" do
        patch company_path(company)
        assigns(:company).should eq(company)
      end

      it "does not change   company's attributes" do
        patch company_path(company)
        company.reload
        company.email.should_not eq('abc@gmail.com')
      end

      it "re-renders the edit method" do
        patch company_path(company)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the company" do
      expect{
        delete company_path(company)
      }.to change(company,:count).by(-1)

      expect(response.status).to eq(200)

    end

    it "redirects to companies#index" do
      delete company_path(company)
      response.should redirect_to companies_url
    end
  end
end
