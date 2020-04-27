require 'rails_helper'

RSpec.describe V1::GroupEventsController, type: :controller do
  let(:valid_attributes) { build(:published_event).attributes }
  let(:invalid_attributes) { build(:invalid_event).attributes }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      group_event = GroupEvent.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      group_event = GroupEvent.create! valid_attributes
      get :show, params: {id: group_event.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new GroupEvent" do
        expect {
          post :create, params: {group_event: valid_attributes}, session: valid_session
        }.to change(GroupEvent, :count).by(1)
      end

      it "renders a JSON response with the new group_event" do

        post :create, params: {group_event: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(/.*application\/json.*/)
        expect(response.location).to eq(v1_group_event_url(GroupEvent.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new group_event" do

        post :create, params: {group_event: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(/.*application\/json.*/)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {  build(:published_event).attributes }

      it "updates the requested group_event" do
        group_event = GroupEvent.create! valid_attributes
        put :update, params: {id: group_event.to_param, group_event: new_attributes}, session: valid_session
        group_event.reload
      end

      it "renders a JSON response with the group_event" do
        group_event = GroupEvent.create! valid_attributes

        put :update, params: {id: group_event.to_param, group_event: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(/.*application\/json.*/)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the group_event" do
        group_event = GroupEvent.create! valid_attributes

        put :update, params: {id: group_event.to_param, group_event: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(/.*application\/json.*/)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested group_event" do
      group_event = GroupEvent.create! valid_attributes
      expect {
        delete :destroy, params: {id: group_event.to_param}, session: valid_session
      }.to change(GroupEvent, :count).by(-1)
    end
  end

end
