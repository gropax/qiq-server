require 'rails_helper'

RSpec.describe "Notes", :type => :request do
  let(:valid_attributes) {
    {content: "This is a cool note"}
  }

  let(:invalid_attributes) {
    {content: ""}
  }

  describe "GET /notes" do
    it "returns all notes" do
      FactoryGirl.create :note, {content: "This is a cool note"}
      FactoryGirl.create :note, {content: "This is another cool note"}

      get "/notes.json"

      json = JSON.parse(response.body)
      note_contents = json.map { |n| n["content"] }

      expect(note_contents).to match_array([
        "This is a cool note",
        "This is another cool note"
      ])
    end
  end

  describe "GET /notes/:id" do
    it "returns a note" do
      note = FactoryGirl.create :note, { content: "This is a cool note"}

      get "/notes/#{note.id}.json"

      expect(response).to be_success
      expect(json["content"]).to eq("This is a cool note")
    end
  end

  describe "POST /notes" do
    describe "with valid parameters" do
      it "creates a new note" do
        expect {
          post "/notes.json", {note: valid_attributes}
        }.to change(Note, :count).by(1)
      end

      it "returns the new note" do
        post "/notes.json", {note: valid_attributes}

        expect(response).to have_http_status(:created)
        expect(json["content"]).to eq("This is a cool note")
      end
    end

    describe "with invalid parameters" do
      it "doesn't create a note" do
        expect {
          post "/notes.json", {note: invalid_attributes}
        }.not_to change(Note, :count)
      end

      it "returns errors" do
        post "/notes.json", {note: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({"content" => ["can't be blank"]})
      end
    end
  end

  describe "PUT /notes/:id" do
    context "with valid attributes" do
      it "updates a note" do
        note = FactoryGirl.create :note, {content: "Before update"}

        put "/notes/#{note.id}.json", {note: valid_attributes}

        content = Note.find(note.id).content
        expect(content).to eq("This is a cool note")
      end

      it "returns the note" do
        note = FactoryGirl.create :note, {content: "Before update"}

        put "/notes/#{note.id}.json", {note: valid_attributes}

        expect(response).to be_success
        expect(json["content"]).to eq("This is a cool note")
      end
    end

    context "with invalid attributes" do
      it "returns error if wrong note params" do
        note = FactoryGirl.create :note, {content: "Before update"}

        put "/notes/#{note.id}.json", {note: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json).to eq({"content" => ["can't be blank"]})
      end
    end
  end
end
