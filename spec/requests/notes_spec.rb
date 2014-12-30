require 'rails_helper'

RSpec.describe "Notes", :type => :request do
  describe "GET /notes" do
    it "returns all notes" do
      FactoryGirl.create :note, {content: "This is a cool note"}
      FactoryGirl.create :note, {content: "This is another cool note"}

      get "/notes.json", {}#, {"Content-Type" => "application/json"}

      binding.pry
      json = JSON.parse(response.body)
      note_contents = json.map { |n| n["content"] }

      expect(note_contents).to match_array([
        "This is a cool note",
        "This is another cool note"
      ])
    end
  end
end
