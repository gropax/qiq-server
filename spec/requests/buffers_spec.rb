require 'rails_helper'

RSpec.describe "Buffers", :type => :request do
  let(:valid_attributes) {
    {name: "project/chinese"}
  }

  let(:invalid_attributes) {
    {name: ""}
  }

  describe "GET /buffers" do
    it "returns all buffers" do
      FactoryGirl.create :buffer, {name: "project/chinese"}
      FactoryGirl.create :buffer, {name: "project/philosophy"}

      get "/buffers.json"

      buffer_names = json.map { |n| n["name"] }

      expect(buffer_names).to match_array([
        "project/chinese",
        "project/philosophy"
      ])
    end
  end

  describe "GET /buffers/:id" do
    it "returns a buffer" do
      buffer = FactoryGirl.create :buffer, { name: "project/chinese"}

      get "/buffers/#{buffer.id}.json"

      expect(response).to be_success
      expect(json["name"]).to eq("project/chinese")
    end

    it "include notes if present" do
      note = FactoryGirl.create :note
      buffer = FactoryGirl.create(:buffer) { |n| n.notes << note }

      get "/buffers/#{buffer.id}.json"

      expect(json).to have_key("notes")
      expect(json["notes"][0]["content"]).to eq "This is the content of a note"
    end
  end

  describe "POST /buffers" do
    describe "with valid parameters" do
      it "creates a new buffer" do
        expect {
          post "/buffers.json", {buffer: valid_attributes}
        }.to change(Buffer, :count).by(1)
      end

      it "returns the new buffer" do
        post "/buffers.json", {buffer: valid_attributes}

        expect(response).to have_http_status(:created)
        expect(json["name"]).to eq("project/chinese")
      end
    end

    describe "with invalid parameters" do
      it "doesn't create a buffer" do
        expect {
          post "/buffers.json", {buffer: invalid_attributes}
        }.not_to change(Buffer, :count)
      end

      it "returns errors" do
        post "/buffers.json", {buffer: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({"name" => ["can't be blank"]})
      end
    end
  end

  describe "PUT /buffers/:id" do
    context "with valid attributes" do
      it "updates a buffer" do
        buffer = FactoryGirl.create :buffer, {name: "Before update"}

        put "/buffers/#{buffer.id}.json", {buffer: valid_attributes}

        name = Buffer.find(buffer.id).name
        expect(name).to eq("project/chinese")
      end

      it "returns the buffer" do
        buffer = FactoryGirl.create :buffer, {name: "Before update"}

        put "/buffers/#{buffer.id}.json", {buffer: valid_attributes}

        expect(response).to be_success
        expect(json["name"]).to eq("project/chinese")
      end
    end

    context "with invalid attributes" do
      it "returns error if wrong buffer params" do
        buffer = FactoryGirl.create :buffer, {name: "Before update"}

        put "/buffers/#{buffer.id}.json", {buffer: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({"name" => ["can't be blank"]})
      end
    end
  end

  describe "DELETE /buffers/:id" do
    it "deletes a buffer" do
      buffer = FactoryGirl.create :buffer, {name: "To be deleted"}

      expect {
        delete "/buffers/#{buffer.id}.json"
      }.to change(Buffer, :count).by(-1)
    end
  end


  describe "buffering notes" do
    describe "POST /buffers/:id/notes.json" do
      it "adds a note to a buffer" do
        note = FactoryGirl.create :note
        buffer = FactoryGirl.create :buffer

        post "buffers/#{buffer.id}/notes.json", {note_id: note.id}

        expect(Buffer.find(buffer.id).notes).to match_array([note])
      end
    end

    describe "DELETE /buffers/:id/notes/:note_id.json" do
      it "removes a note from a buffer" do
        note = FactoryGirl.create :note
        buffer = FactoryGirl.create :buffer, {notes: [note]}

        delete "buffers/#{buffer.id}/notes/#{note.id}.json"

        expect(Buffer.find(buffer.id).notes).to eq []
      end
    end
  end
end
