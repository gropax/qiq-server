require 'rails_helper'

RSpec.describe "Tags", :type => :request do
  let(:valid_attributes) {
    {name: "Awesome"}
  }

  let(:invalid_attributes) {
    {name: ""}
  }

  describe "GET /tags" do
    it "returns all tags" do
      FactoryGirl.create :tag, {name: "Awesome"}
      FactoryGirl.create :tag, {name: "Marvelous"}

      get "/tags.json"

      tag_names = json.map { |n| n["name"] }

      expect(tag_names).to match_array(["Awesome", "Marvelous"])
    end
  end

  describe "GET /tags/:id" do
    it "returns a tag" do
      tag = FactoryGirl.create :tag, {name: "Awesome"}

      get "/tags/#{tag.id}.json"

      expect(response).to be_success
      expect(json["name"]).to eq("Awesome")
    end
  end

  describe "POST /tags" do
    describe "with valid parameters" do
      it "creates a new tag" do
        expect {
          post "/tags.json", {tag: valid_attributes}
        }.to change(Tag, :count).by(1)
      end

      it "returns the new tag" do
        post "/tags.json", {tag: valid_attributes}

        expect(response).to have_http_status(:created)
        expect(json["name"]).to eq("Awesome")
      end
    end

    describe "with invalid parameters" do
      it "doesn't create a tag" do
        expect {
          post "/tags.json", {tag: invalid_attributes}
        }.not_to change(Tag, :count)
      end

      it "returns errors" do
        post "/tags.json", {tag: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({"name" => ["can't be blank"]})
      end
    end
  end

  describe "PUT /tags/:id" do
    context "with valid attributes" do
      it "updates a tag" do
        tag = FactoryGirl.create :tag, {name: "Before update"}

        put "/tags/#{tag.id}.json", {tag: valid_attributes}

        name = Tag.find(tag.id).name
        expect(name).to eq("Awesome")
      end

      it "returns the tag" do
        tag = FactoryGirl.create :tag, {name: "Before update"}

        put "/tags/#{tag.id}.json", {tag: valid_attributes}

        expect(response).to be_success
        expect(json["name"]).to eq("Awesome")
      end
    end

    context "with invalid attributes" do
      it "returns error if wrong tag params" do
        tag = FactoryGirl.create :tag, {name: "Before update"}

        put "/tags/#{tag.id}.json", {tag: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({"name" => ["can't be blank"]})
      end
    end
  end

  describe "DELETE /tags/:id" do
    it "deletes a tag" do
      tag = FactoryGirl.create :tag, {name: "To be deleted"}

      expect {
        delete "/tags/#{tag.id}.json"
      }.to change(Tag, :count).by(-1)
    end
  end
end
